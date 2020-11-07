package lunchmatch

import akka.NotUsed
import akka.actor.{ActorSystem, Props}
import akka.http.scaladsl.Http
import akka.http.scaladsl.model.StatusCode
import akka.http.scaladsl.model.ws.{BinaryMessage, Message, TextMessage}
import akka.http.scaladsl.server.Directives._
import akka.stream.scaladsl.{Flow, Sink, Source, SourceQueueWithComplete}
import akka.stream.{Materializer, OverflowStrategy}
import com.typesafe.scalalogging.{LazyLogging, StrictLogging}
import de.heikoseeberger.akkahttpplayjson.PlayJsonSupport
import play.api.libs.json.Json

import scala.collection.mutable
import scala.concurrent.duration.Duration
import scala.concurrent.{Await, ExecutionContextExecutor, Promise}

final case class Room(
    host: String,
    members: mutable.Set[String] = mutable.Set[String](),
)

//noinspection TypeAnnotation
class Main extends LazyLogging with PlayJsonSupport {
  implicit val actorSystem: ActorSystem = ActorSystem("lunch-match")
  implicit val executionContext: ExecutionContextExecutor = actorSystem.dispatcher
  implicit val materializer: Materializer = Materializer.matFromSystem(actorSystem)
  val aito = new Aito()

  val rooms = mutable.Map[String, Room]()
  val (busQueue: SourceQueueWithComplete[Event], busSource: Source[Event, NotUsed]) =
    Source.queue[Event](128, OverflowStrategy.dropNew).preMaterialize()

  val wsFlow = Flow.fromMaterializer { (mat, attr) =>
    val (outputRef, source) = Source
      .actorRef[WsResponse](
        completionMatcher = PartialFunction.empty,
        failureMatcher = PartialFunction.empty,
        bufferSize = 128,
        overflowStrategy = OverflowStrategy.dropNew,
      )
      .preMaterialize()
    val actor = mat.system.actorOf(Props(new ActorUserSession(outputRef, this)))
    busSource.to(Sink.actorRef[Event](actor, (), PartialFunction.empty)).run()
    val sink: Sink[WsRequest, NotUsed] = Sink.actorRef[WsRequest](actor, (), PartialFunction.empty)

    val sourceAdapted: Source[Message, NotUsed] = source.map { msg =>
      val str = WsResponse.writes.writes(msg).toString()
      TextMessage(str)
    }
    val sinkAdapted: Sink[Message, NotUsed] = Flow[Message].flatMapConcat {
      case message: TextMessage =>
        val future = message.getStreamedText.runWith(Sink.collection[String, Vector[String]], mat).map { lines =>
          Json.parse(lines.mkString).as[WsRequest]
        }
        Source.future(future)
      case message: BinaryMessage =>
        message.getStreamedData.runWith(Sink.ignore, mat)
        Source.empty
    }.to(sink)

    Flow.fromSinkAndSource[Message, Message](sinkAdapted, sourceAdapted)
  }

  val apiV1 = {
    path("room" / "create") {
      post {
        entity(as[RequestRoomCreate]) { request =>
          val roomId = Gen.randStr()
          assert(!rooms.contains(roomId))
          rooms.update(roomId, Room(host = request.userId))
          val response = ResponseRoomCreate(roomId)
          complete(response)
        }
      }
    } ~
    path("filters") {
      get {
        ???
      } ~
      post {
        ???
      }
    }
  }

  val route = {
    pathPrefix("api" / "v1") {
      apiV1
    } ~
    path("socket") {
      handleWebSocketMessages(wsFlow)
    }
  }
}

object Main extends App with StrictLogging {
  val main = new Main()

  import main._

  val bindingFuture = Http().newServerAt("0.0.0.0", 8080).bind(route)
  logger.info("Server online at port 8080")
  Await.result(Promise[Unit]().future, Duration.Inf)
  logger.info("Stopping...")
  bindingFuture
    .flatMap(_.unbind()) // trigger unbinding from the port
    .onComplete(_ => actorSystem.terminate()) // and shutdown when done
}
