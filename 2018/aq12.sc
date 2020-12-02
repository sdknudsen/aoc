import scala.io.Source

object q12 {

  val max = 2
  type Point = (Int, Int)

  def pointAdd(a: Point, b: Point): Point = (a,b) match {
    case ((x1, y1), (x2, y2)) => (x1 + x2, y1 + y2)
  }

  def addStep(xss: Array[Array[List[Point]]]): Array[Array[List[Point]]] = {
    val size = Math.max(xss.length, xss(0).length)
    val arr = Array.ofDim[List[Point]](size, size)

    for(i <- 0 until size) {
      for(j <- 0 until size) {
        for(point <- xss(i)(j)) {
          val newP = pointAdd(point, (i,j))
          arr(newP._1)(newP._2) = point +: arr(newP._1)(newP._2)
        }
      }
    }
    arr
  }

  def recNextState(xs: List[Char], m: Map[String, Char]): List[Char] =
    xs match {
      case a :: b :: c :: d :: e :: tl  =>
        val key = (a :: b :: c :: d :: e :: Nil).toArray.mkString
        val char = if(m.isDefinedAt(key)) m(key) else '.'
        char :: recNextState(b :: c :: d :: e :: tl, m)
      case x => Nil

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
    val fs = recNextState(ls, m)

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

    val pad = 20

    print("\t")
    val prefSuff = List.fill(pad)('.')

    val map = formatInput(body)
    var currState = prefSuff ++ (initial.toList) ++ prefSuff
    currState.foreach(print)

    for(i <- 1 to 20) {
      currState = getNextState(currState, map)
      print(s"\n$i:\t")
      currState.foreach(print)

    }
    val finalSum = currState
      .zipWithIndex
      .map(x => (x._1, x._2 - pad))
      .filter(_._1 == '#')
      .map(_._2)
      .sum

    println()
    println(finalSum)

  }
}
