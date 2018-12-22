import scala.io.Source
// import scala.collection.mutable.Set



object q {

  type Circle = (List[Int], List[Int])

  var circle: (List[Int], List[Int]) = (List(0), List())

  def rev(ls: List[Int], acc: List[Int]): List[Int] = ls match {
    case Nil => acc
    case h :: t => rev(t, h :: acc)
  }

  def pop(circle: Circle): (Int, Circle) = circle match {
    case (h :: l, r) => (h, (l, r))
    case (l, r) => pop(toLeft(toLeft((l,r), 1), -1))
  }

  // def printCirc(circle: Circle): Unit = circle match {
  //   case (h :: l, r) =>
  //     l.reverse.foreach{ x => print(s"$x\t") }
  //     print(s"($h)\t")
  //     r.foreach{ x => print(s"$x\t") }
  //     println()
  // }

  def addElem(circle: Circle, e: Int): Circle = circle match {
    // case (l, a :: b :: r) => (e :: a :: l, b :: r)
    case (l, r) => (e :: l, r)
  }

  def toLeft(circle: Circle, n: Int): Circle = circle match {
    case (h1 :: t1, h2 :: t2) =>
      if(n == 0)
        circle
      else if(n > 0)
        toLeft((t1, h1 :: h2 :: t2), n - 1)
      else
        toLeft((h2 :: h1 :: t1, t2), n + 1)

    case (Nil, h :: t) =>
      if(n == 0)
        circle
      else if(n > 0) {
        val len = (h :: t).length
        val (first, last) = (h :: t).splitAt(len / 2)
        val reversed = rev(last, Nil)
        toLeft((reversed, first), n)
      }
      else
        toLeft((h :: Nil, t), n + 1)

    case (h :: t, Nil) =>
      if(n == 0)
        circle
      else if(n > 0)
        toLeft((t, h :: Nil), n - 1)
      else {
        val len = (h :: t).length
        val (first, last) = (h :: t).splitAt(len / 2)
        // print("{")
        // first.foreach(x => print(s"$x\t"))
        // print(", ")
        // last.foreach(x => print(s"$x\t"))
        // println("}")
        val reversed = rev(last, Nil)
        toLeft((first, reversed), n)
      }
    case (Nil, Nil) => (Nil, Nil)
  }

  // val nPeople   = 9
  // val maxMarble = 25
  // val nPeople   = 30
  // val maxMarble = 5807
  val nPeople   = 416
  val maxMarble = 7197500

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
        // println(s"elf: $elf")
        // println(s"minus7pos: $minus7Pos")
        // println(s"split: $split")
        // println(split)
        // println(s"score: ${score(elf)}")

        score(elf) += marble
        circle = toLeft(circle, 7) // (curr - 7 + circle.length) % circle.length

        val (top, newCircle) = pop(circle)
        score(elf) += top
        circle = toLeft(newCircle, -1)
        // circle = newCircle

      } else {
        circle = toLeft(circle, -1)
        circle = addElem(circle, marble)
      }
      // printCirc(circle)
      // var i = 0
      // circle.foreach{ x => if(i == curr) print(s"($x)\t") else print(s"$x\t"); i += 1 }

    }
    println(s"max: ${score.max}")

  }



  def main(args: Array[String]) = {
    game()
  }
}
