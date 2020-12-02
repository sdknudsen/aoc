import scala.io.Source

object q10 {

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

  def showMat[A](xs: Array[Array[A]]) = xs.foreach{ line => line.foreach(x => print(s"$x,\t")); println }


  def formatInput(lines: Array[String]): Array[(Point, Point)] = {
    val fmt = "position=< *([-0-9]+), *([-0-9]+)> velocity=< *([-0-9]+), *([-0-9]+)>".r

    lines.map { line =>
      line match {
        case fmt(px, py, vx, vy) => ((px.toInt, py.toInt), (vx.toInt, vy.toInt))
      }
    }
  }

  def main(args: Array[String]) = {
    // val filename = "in20.txt"
    val filename = "/home/sknudsen/Desktop/q10t"
    // val filename = "parsed_in20.txt"

    println("starting")

    val lines = Source.fromFile(filename).getLines.toArray
    val formatted = formatInput(lines)
    val size = 100
    val arr = Array.ofDim[List[Point]](size, size)

    for(((x,y), v) <- formatted) {
      arr(x)(y) = v +: arr(x)(y)
      }

    val iterations = 10
    var mat: Array[Array[List[Point]]] = arr
    showMat(mat)
    println("begin")
    for(i <- 1 to iterations) {
      mat = addStep(mat)
      showMat(mat)
    }


    // val positions =
  }
}
