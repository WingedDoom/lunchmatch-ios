package lunchmatch

import org.scalatest.concurrent.Futures

import scala.concurrent.{Await, Future}

trait PostfixAwait extends Futures {
  implicit class FutureSyntax[T](private val inner: Future[T]) {
    def await(): T = Await.result(inner, patienceConfig.timeout)
  }
}
