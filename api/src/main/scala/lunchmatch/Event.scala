package lunchmatch

final case class Event(
    recipient: String,
    response: WsResponse,
)
