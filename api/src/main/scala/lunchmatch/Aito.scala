package lunchmatch

import java.nio.charset.Charset

import akka.actor.ActorSystem
import akka.http.scaladsl.Http
import akka.http.scaladsl.model.headers.RawHeader
import akka.http.scaladsl.model.{ContentTypes, HttpEntity, HttpMethods, HttpRequest}
import akka.stream.scaladsl.Sink
import akka.util.ByteString
import play.api.libs.json._

import scala.concurrent.{ExecutionContext, Future}

class Aito(implicit actorSystem: ActorSystem, executionContext: ExecutionContext) {
  val baseUrl = "https://lunchmatch.aito.app"
  val token: String = System.getenv("AITO_TOKEN")

  private def request(endpoint: String, body: String): Future[String] = {
    val request = HttpRequest(
      method = HttpMethods.POST,
      uri = baseUrl + endpoint,
      entity = HttpEntity(ContentTypes.`application/json`, body),
    ).withHeaders(RawHeader("X-Api-Key", token))
    Http().singleRequest(request).flatMap { response =>
      assert(response.status.isSuccess())
      val vector: Future[Vector[ByteString]] = response.entity.dataBytes.runWith(Sink.collection)
      vector.map { strings => strings.foldLeft(ByteString.empty)(_ ++ _).decodeString(Charset.forName("UTF-8")) }
    }
  }

  def recommend(userId: String): Future[Vector[Int]] = {
    val jsonUserId = JsString(userId).toString()
    val body =
      s"""
         |{
         |    "from": "ratings",
         |    "where": {
         |        "userID": $jsonUserId
         |    },
         |    "recommend": "placeID",
         |    "goal": { "rating": {"$$gt": 0} },
         |    "limit": 15
         |}
         |""".stripMargin
    request("/api/v1/_recommend", body).map { response =>
      val result = Json.parse(response).as[JsObject]
      result.\("hits").as[JsArray].value.toVector.map(_.as[JsObject].\("feature").as[JsNumber].value.toInt)
    }
  }

  def insertUserChoice(userId: String, placeId: String): Future[Unit] = {
    val jsonUserId = JsString(userId).toString()
    val jsonPlaceId = JsString(placeId).toString()
    val body =
      s"""
         |{
         |    "userID": $jsonUserId,
         |    "placeID": $jsonPlaceId,
         |    "rating": 2,
         |    "service_rating": 2,
         |    "food_rating": 2
         |}
         |""".stripMargin
    request("/api/v1/data/ratings", body).map { response => () }
  }
}
