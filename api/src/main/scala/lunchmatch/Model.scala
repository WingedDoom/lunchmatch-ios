package lunchmatch

import play.api.libs.json.{
  Format,
  JsDefined,
  JsObject,
  JsResult,
  JsString,
  JsSuccess,
  JsUndefined,
  JsValue,
  Json,
  Reads,
  Writes,
}

trait Request {
  def userId: String
}

sealed trait WsRequest
object WsRequest {
  implicit val read: Reads[WsRequest] = { (json: JsValue) =>
    json.as[JsObject].\("type").as[JsString].value match {
      case "join" => JsSuccess(json.as[WsRequestJoin])
      case "start_match" => JsSuccess(WsRequestStartMatch)
      case "select_options" => JsSuccess(json.as[WsRequestSelectOptions])
      case "ping" => JsSuccess(WsRequestPing)
    }
  }
}

sealed trait WsResponse {
  def `type`: String
}
object WsResponse {
  implicit val writes: Writes[WsResponse] = {
    case o: WsResponseUsers => WsResponseUsers.format.writes(o)
    case o: WsResponseFilters => WsResponseFilters.format.writes(o)
    case o: WsResponseOptions => WsResponseOptions.format.writes(o)
    case o: WsResponseFinal => WsResponseFinal.format.writes(o)
    case o: WsResponsePong => WsResponsePong.format.writes(o)
  }
}

final case class ResponseFilters(
    cuisines: Vector[String],
    excludeList: Vector[String],
)
object ResponseFilters {
  implicit val format: Format[ResponseFilters] = Json.format
}

final case class RequestUpdateFilters(
    userId: String,
    cuisines: Vector[String],
    excludeList: Vector[String],
    priceMin: Int,
    priceMax: Int,
) extends Request
object RequestUpdateFilters {
  implicit val format: Format[RequestUpdateFilters] = Json.format
}

final case class RequestRoomCreate(
    userId: String,
) extends Request
object RequestRoomCreate {
  implicit val format: Format[RequestRoomCreate] = Json.format
}

final case class ResponseRoomCreate(
    roomId: String,
)
object ResponseRoomCreate {
  implicit val format: Format[ResponseRoomCreate] = Json.format
}

final case class WsRequestJoin(
    userId: String,
    roomId: String,
) extends WsRequest
object WsRequestJoin {
  implicit val format: Format[WsRequestJoin] = Json.format
}

final case class WsResponseUsers(
    userIds: Vector[String],
    hostUserId: String,
    `type`: "users" = "users",
) extends WsResponse
object WsResponseUsers {
  implicit val format: Format[WsResponseUsers] = Json.format
}

final case class WsResponseFilters(
    values: Vector[String],
    `type`: "filters" = "filters",
) extends WsResponse
object WsResponseFilters {
  implicit val format: Format[WsResponseFilters] = Json.format
}

object WsRequestStartMatch extends WsRequest

final case class WsResponseOptions(
    cafes: Vector[Cafe],
    `type`: "options" = "options",
) extends WsResponse
object WsResponseOptions {
  implicit val format: Format[WsResponseOptions] = Json.format
}

final case class Cafe(
    id: String,
    name: String,
    desc: String,
)
object Cafe {
  implicit val format: Format[Cafe] = Json.format
}

object WsRequestPing extends WsRequest

final case class WsRequestSelectOptions(
    selectedIds: Vector[String],
) extends WsRequest
object WsRequestSelectOptions {
  implicit val format: Format[WsRequestSelectOptions] = Json.format
}

final case class WsResponseFinal(
    cafes: Vector[Cafe],
    `type`: "final" = "final",
) extends WsResponse
object WsResponseFinal {
  implicit val format: Format[WsResponseFinal] = Json.format
}

final case class WsResponsePong(
    `type`: String = "pong",
) extends WsResponse
object WsResponsePong {
  implicit val format: Format[WsResponsePong] = Json.format
}
