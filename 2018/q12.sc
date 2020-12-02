import scala.io.Source

object q12 {

  val max = 2

  def recNextState(xs: List[Char], m: Map[String, Char], acc: List[Char]): List[Char] =
    xs match {
      case a :: b :: c :: d :: e :: tl  =>
        val key = (a :: b :: c :: d :: e :: Nil).toArray.mkString
        val char = if(m.isDefinedAt(key)) m(key) else '.'
        recNextState(b :: c :: d :: e :: tl, m, char :: acc)
      case x =>
        // '.' ::
          '.' :: '.' :: (('.' :: '.' :: acc).reverse)

    }

  def getNextState(xs: List[Char], m: Map[String, Char]): List[Char] = {
    val prefix = List.fill(max)('.')
    val ls = prefix ++ xs ++ prefix
    // println()
    // println(s"xs: ${xs.mkString}")
    // println(s"ls: ${ls.mkString}")
    // key.foreach(print)
    // println(key)
    // println("done")
    // println(s"fs: ${fs.mkString}")
    val fs = recNextState(ls, m, Nil)

    // val prefSuff = List.fill(2)('.')
    // prefSuff ++ fs ++ prefSuff
    fs
    // for(i <- 0 to arr.length - 5) { }
  }

  def showMat[A](xs: Array[Array[A]]) = xs.foreach{ line => line.foreach(x => print(s"$x,\t")); println }


  def formatInput(lines: Array[String]): Map[String, Char] = {
    val fmt = "([.#]+) => ([.#])".r

    val arr = lines.map { line =>
      line match {
        case fmt(mask, out) => (mask, out.toCharArray.head)
      }
    }
    arr.toMap
  }

  def main(args: Array[String]) = {
    // val filename = "/home/sknudsen/Desktop/q12t"
    val filename = "/home/sknudsen/Desktop/q12input"

    val lines = Source.fromFile(filename).getLines.toArray
    val head = lines.head
    val body = lines.drop(2)

    val headFmt = "initial state: ([.#]+)".r
    val initial = head match {
      case headFmt(init) => init.toCharArray
    }

    val iterCount = 3999

    print("\t")

    val map = formatInput(body)
    var currState = (initial.toList) //  ++ prefSuff
    currState.foreach(print)
    var currSum = 0L

    for(i <- 1 to iterCount) {
      if(i % 100000 == 0)
        println(s"${i.toDouble * 100 / iterCount.toDouble}% completed")
      currState = getNextState(currState, map)
      // print(s"\n$i:\t")
      // currState.foreach(print)

      val sum = currState.foldLeft((iterCount * -2L, 0L)){
        case ((n, sum), c) => if(c == '#')
          (n + 1L, sum + n)
        else (n + 1L, sum)
      }._2

      println(sum - currSum)
      // println(currSum)
      currSum = sum
    }
    println()
    println(currSum)


    // val finalSum = currState
    //    .zipWithIndex
    //    .map(x => (x._1, x._2 - 20))
    //    .filter(_._1 == '#')
    //    .map(_._2)
    //    .sum


  }
}
