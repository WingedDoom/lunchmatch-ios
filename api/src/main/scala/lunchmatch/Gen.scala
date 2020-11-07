package lunchmatch

import scala.util.Random

object Gen {
  val alpha = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  def randStr(n: Int = 6): String = (1 to n).map(_ => alpha(Random.nextInt(alpha.length))).mkString
}
