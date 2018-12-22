import scala.io.Source
// import scala.collection.mutable.Set

object q {

  // val nPeople   = 9
  // val maxMarble = 25
  val nPeople   = 416
  val maxMarble = 7197500

  var circle: Vector[Int] = Vector(0)
  var curr: Int = 0
  var elf = 0
  val score: Array[Long] = Array.ofDim(nPeople + 1)

  def game(): Unit = {
    // var marbles: Set[Int] = (1 until maxMarble).toSet

    for(marble <- 1 to maxMarble) {
      elf = (marble - 1) % nPeople + 1
      // print(s"[$elf]\t")

      if(marble % 100000 == 0)
        println(s"${marble.toDouble * 100 / maxMarble.toDouble}% completed")
      if(marble % 23 == 0) {
        score(elf) += marble
        // println(s"elf: $elf")
        val minus7Pos = (curr - 7 + circle.length) % circle.length
        // println(s"minus7pos: $minus7Pos")

        val split = circle.splitAt(minus7Pos)
        // println(s"split: $split")
        // println(split)
        score(elf) += circle(minus7Pos)
        // println(s"score: ${score(elf)}")
        circle = split._1 ++ (split._2.tail)
        curr = split._1.length % circle.length


      } else {

        val newPos = (curr + 1) % circle.length
        val split = circle.splitAt(newPos+1)
        circle = split._1 ++ Vector(marble) ++ split._2
        curr = newPos + 1
      }
      // var i = 0
      // circle.foreach{ x => if(i == curr) print(s"($x)\t") else print(s"$x\t"); i += 1 }

    }
    println(s"max: ${score.max}")

  }



  def main(args: Array[String]) = {
    game()
  }
}
