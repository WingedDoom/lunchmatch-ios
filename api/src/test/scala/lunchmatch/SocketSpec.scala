package lunchmatch

import akka.http.scaladsl.model.{ContentType, MediaType, MediaTypes}
import akka.http.scaladsl.testkit.{ScalatestRouteTest, WSProbe}
import org.scalatest.BeforeAndAfterAll
import org.scalatest.flatspec.AnyFlatSpec
import org.scalatest.matchers.should.Matchers
import play.api.libs.json.Json

import scala.concurrent.duration.DurationInt

//noinspection TypeAnnotation
class SocketSpec extends AnyFlatSpec with BeforeAndAfterAll with PostfixAwait with Matchers with ScalatestRouteTest {
  val main = new Main()
  import main._
  implicit val actorSystem = main.actorSystem

  override implicit val patienceConfig: PatienceConfig = PatienceConfig(timeout = 1.second)

  override def afterAll(): Unit = {
    system.terminate()
    super.afterAll()
  }

  "joining a room" should "work" in {
    val createRoom =
      s"""
         |{
         |    "userId": "Shrek"
         |}
         |""".stripMargin
    var roomId: String = null
    Post("/api/v1/room/create")
      .withEntity(ContentType(MediaTypes.`application/json`), createRoom.getBytes) ~> route ~> check {
      val room = responseAs[ResponseRoomCreate]
      roomId = room.roomId
    }

    val wsClient = WSProbe()

    WS("/socket", wsClient.flow) ~> route ~> check {
      isWebSocketUpgrade shouldEqual true
      wsClient.inProbe.expectSubscription()
      val join = s"""
                    |{
                    |    "type": "join",
                    |    "userId": "Shrek",
                    |    "roomId": "$roomId"
                    |}
                    |""".stripMargin
      wsClient.sendMessage(join)
      wsClient.expectNoMessage(100.millis)
    }
  }

  "pong" should "work" in {
    val wsClient = WSProbe()

    WS("/socket", wsClient.flow) ~> route ~> check {
      isWebSocketUpgrade shouldEqual true
      val ping = s"""
                    |{
                    |    "type": "ping"
                    |}
                    |""".stripMargin
      wsClient.sendMessage(ping)
      val response = wsClient.expectMessage().asTextMessage.getStrictText
      Json.parse(response).as[WsResponsePong].`type` shouldBe "pong"
    }
  }
}
