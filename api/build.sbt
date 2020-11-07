name := "lunchmatch"

version := "0.1"

scalaVersion := "2.13.3"

val AkkaVersion = "2.6.8"
val AkkaHttpVersion = "10.2.1"

scalacOptions += "-Ymacro-annotations"

libraryDependencies ++= Vector(
  "org.typelevel" %% "cats-core" % "2.1.1",
  "org.typelevel" %% "cats-effect" % "2.2.0",
  "io.monix" %% "monix" % "3.1.0",
  "com.typesafe.akka" %% "akka-actor" % AkkaVersion,
  "com.typesafe.akka" %% "akka-stream" % AkkaVersion,
  "com.typesafe.akka" %% "akka-http" % AkkaHttpVersion,
  "com.typesafe.scala-logging" %% "scala-logging" % "3.9.2",
  "com.typesafe.play" %% "play-json" % "2.9.1",
  "ch.qos.logback" % "logback-classic" % "1.2.3",
  "org.manatki" %% "derevo-cats" % "0.11.5",
  "de.heikoseeberger" %% "akka-http-play-json" % "1.35.2",
)

libraryDependencies ++= Vector(
  "org.scalatest" %% "scalatest" % "3.2.2",
  "com.typesafe.akka" %% "akka-stream-testkit" % AkkaVersion,
  "com.typesafe.akka" %% "akka-http-testkit" % AkkaHttpVersion,
).map(_ % Test)