object q {

  var size = 300
  val serial = 7803

  def powerLevel(xss: Array[Array[Long]], x: Int, y: Int): Int = {
    val rackId = x + 10
    val levelArr: Array[Char] = ((rackId * y + serial) * rackId)
      .toString
      .toCharArray
      .reverse

     val level: Int = if(levelArr.length >= 3) {
       val c: Char = levelArr(2)
       c - '0'
     }
     else 0

    level - 5
  }

  def computeLevels(mat: Array[Array[Long]]): Array[Array[Long]] = {
    for (x <- 0 until size){
      for (y <- 0 until size){
          mat(x)(y) = powerLevel(mat, x, y)
      }
    }
    mat
  }

  def getMaxPos(xss: Array[Array[Long]], n: Int): ((Int, Int), Int, Long) = {
    val arr = Array.ofDim[Boolean](size, size)

    var maxSum: Long = 0
    var currSum: Long = 0
    var maxPos = (0, 0)

    for (x <- 0 to size - n){
      for (y <- 0 to size - n){
        currSum = 0
        for (xOff <- 0 until n) {
          for (yOff <- 0 until n) {
            currSum += xss(x + xOff)(y + yOff)
          }
        }
        maxSum = Math.max(maxSum, currSum)
        if(currSum == maxSum)
          maxPos = (x,y)
      }
    }
    (maxPos, n, maxSum)
  }

  def showMat[A](xs: Array[Array[A]]) = xs.transpose.foreach{ line => line.foreach(x => print(s"$x,\t")); println }
  def showMatFrom[A](xss: Array[Array[A]], x: Int, y: Int) = xss.drop(x).map(_.drop(y)).transpose.foreach{ line => line.foreach(x => print(s"$x,\t")); println }

  def main(args: Array[String]) = {

    val initMat: Array[Array[Long]] = Array.ofDim(size, size)
    val mat = computeLevels(initMat)
    // showMat(mat)
    // println(mat(101)(153))
    var maxPos = (0,0)
    var maxSum: Long = 0
    for(i <- 1 to 300) {
      val (pos, size, currSum) = getMaxPos(mat, i)
      maxSum = Math.max(maxSum, currSum)
      if(currSum == maxSum) {
        maxPos = pos
        println(s"maxPos: $maxPos")
        println(s"size: $size")
        println(s"maxSum: $maxSum")
      }
    }

    // println(powerLevel(initMat, 3,5))
  }
}

