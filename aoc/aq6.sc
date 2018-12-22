import scala.io.Source
import scala.collection.mutable.Set

object q {

  var size = 0
  var nEntries = 0

  // def arrMin(m: RealMatrix[Int], n: RealMatrix[Int]): RealMatrix[Int] = {
  // m + n + (-1 * (m  + (-1 * n)))
  // n}
  def getMinEntry(xss: Array[Array[Array[Int]]], i: Int, j: Int): Int = {
    var min = Integer.MAX_VALUE
    for(c <- 0 until nEntries)
      min = Math.min(min, xss(c)(i)(j))

    var count = 0
    var index = -1
    for(c <- 0 until nEntries) {
      if(xss(c)(i)(j) == min) {
        count += 1
        index = c
      }
    }
    if(count == 1) index else {
      // println(count)

      -1
    }
  }

  def getCount(xss: Array[Array[Int]]): Array[Int] = {
    val counts: Array[Int] = new Array(nEntries)
    for (i <- 0 until size){
      for (j <- 0 until size){
        if(xss(i)(j) >= 0)
          // counts.update(xss(i)(j), xss(i)(j) + 1)
          counts(xss(i)(j)) = counts(xss(i)(j)) + 1
      }
    }
    counts
  }

  def getMinMat(xss: Array[Array[Array[Int]]]): Array[Array[Int]] = {
    val arr = Array.ofDim[Int](size, size)

    for(i <- 0 until size) {
      for(j <- 0 until size) {
        arr(i)(j) = getMinEntry(xss, i, j)
        }
      }
    arr
  }

  def getOuterPoints(xs: Array[Array[Int]], maxRow: Int, minRow: Int, maxCol: Int, minCol: Int): Set[Int] = {
    var s: Set[Int] = Set()
    for(i <- minRow to maxRow) {
      s = s + xs(i)(minCol)
      s = s + xs(i)(maxCol)
    }
    for(i <- minCol to maxCol) {
      s = s + xs(minRow)(i)
      s = s + xs(maxRow)(i)
    }
    s
  }

  def toIntArr(p: (Int, Int)): Array[Array[Int]] = {

    var arr = Array.ofDim[Int](size, size)

    // val id = line(0) val fromLeft = line(1) val fromTop = line(2) val width = line(3) val height = line(4)
    for(i <- 0 until size) {
      for(j <- 0 until size) {
        arr(i)(j) = (p._1 - i).abs + (p._2 - j).abs
      }
    }
    arr
  }


  def showMat(xs: Array[Array[Int]]) = xs.foreach{ line => line.foreach(x => print(s"$x,\t")); println }

  def main(args: Array[String]) = {
    // val arr = Source.fromFile("/home/sknudsen/Desktop/q6t").getLines.toArray
    val arr = Source.fromFile("/home/sknudsen/Desktop/q6input").getLines.toArray
    .map(_.split(", ")).map { case Array(a,b) => (a.toInt, b.toInt) }

    val maxRow = arr.map(_._1).max
    val minRow = arr.map(_._1).min
    val maxCol = arr.map(_._2).max
    val minCol = arr.map(_._2).min

    nEntries = arr.length
    size = Math.max(maxRow, maxCol) + 1

    val mats = arr.map(x => toIntArr(x))
    val closest = getMinMat(mats)
    val ranking = getCount(closest)
    val inf = getOuterPoints(closest, maxRow, minRow, maxCol, minCol)
    val filtered = ranking.zipWithIndex.filter(x => !inf.contains(x._2))

    // val filtered = arr.zip(ranking).filter(x => x._1._1 < maxRow && x._1._1 > minRow && x._1._2 < maxCol && x._1._2 > minCol)
    // filtered.foreach(println)
    // val highScore = filtered.map(_._2).max
    // showMat(closest)

    val highScore = filtered.map(_._1).max
    println(highScore)

    // (toIntArr(x).foreach(println))

    // arr.foreach{x =>
    //   showMat(toIntArr(x))
    //   println()
    // }
    // showMat(getMinMat(arr))
  }
}

