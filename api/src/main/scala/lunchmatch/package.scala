import play.api.libs.json.Format

package object lunchmatch {
  implicit def singletonFormat[T <: Singleton with String]: Format[T] =
    implicitly[Format[String]].asInstanceOf[Format[T]]
}
