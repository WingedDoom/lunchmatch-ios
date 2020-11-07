package lunchmatch

import akka.actor.{Actor, ActorRef}

class ActorUserSession(outputRef: ActorRef, main: Main) extends Actor {
  override def receive: Receive = start

  def start: Receive = {
    case WsRequestJoin(userId, roomId) =>
      val room = main.rooms(roomId)
      room.members.update(userId, included = true)
      val event = WsResponseUsers(room.members.toVector, room.host)
      room.members.foreach { user => main.busQueue.offer(Event(user, event)) }
      context.become(running(userId, roomId))
    case WsRequestPing => outputRef ! WsResponsePong()
  }

  def running(userId: String, roomId: String): Receive = {
    case Event(`userId`, response) => outputRef ! response
    case WsRequestPing => outputRef ! WsResponsePong()
    case _ =>
  }
}
