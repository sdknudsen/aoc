import scala.io.Source

object q {

  def toIntArr(xs: List[(Either[Boolean,String],Int)]) : Array[Int] = {
    var awake = true
    var list = xs.tail
    var arr = (0 to 59).toList.toArray
    for(i <- 0 to 59) {
      if(!list.isEmpty && i == list.head._2) {
        awake = list.head._1.left.get
        list = list.tail
      }
      arr(i) = if(!awake) 1 else 0
    }
    arr
  }

  def maxGuardMinute(xss: Array[Array[Int]], nightFilter: Array[Boolean]): (Int,Int) = {
    val validNights = xss.zip(nightFilter).filter(_._2).map(_._1)
    val minuteSums = validNights.transpose.map(_.reduce(_ + _))
    minuteSums.zipWithIndex.maxBy(_._1)
  }

  def sleepyGuard(xss: Array[Array[Int]]): Int = {
    val sleepSums = xss.map(_.reduce(_ + _))
    sleepSums.indexOf(sleepSums.max)

//    var max = Integer.MIN_VALUE
//    for(c <- 0 until nEntries)
//      min = Math.min(min, xss(c)(i)(j))
//
//    var count = 0
//    var index = -1
//    for(c <- 0 until nEntries) {
//      if(xss(c)(i)(j) == min) {
//        count += 1
//        index = c
//      }
//    }
//    if(count == 1) index else {
//      // println(count)
//
//      -1
//    }
  }


def joinGuard(xs: List[(Boolean, (Either[Boolean,String],String,String))]) : List[List[(Either[Boolean,String],String,String)]] = xs match {
	case (true,d) :: tail => joinGuard((false,d) :: tail)
	case ys => 
	
	val (head, tail) = ys.span(!_._1)
	if(tail.isEmpty)
		head.map(_._2) :: Nil
	else
		head.map(_._2) :: joinGuard(tail)
}

  def showMat(xs: Array[Array[Int]]) = xs.foreach{ line => line.foreach(print(_) + ", "); println }

  def main(args: Array[String]) = {
    // val arr = Source.fromFile("/home/sknudsen/Desktop/q4input").getLines.toArray
    val arr = Source.fromFile("/home/sknudsen/Desktop/q4u").getLines.toArray
    // val arr = arr0.map(_.filter(_ != '[').split(":] ".toCharArray))
    // val arr = arr0.map(_.filter(_ != '[').split(']'))
    // arr(0).foreach(println)
    // val y = arr.span{line => line.contains("Guard")}
    // y.toList.foreach(println)


val formatted = arr.map(_.split(']')).map { case Array(d, e) =>
      val ds = d.split(" :".toCharArray)
      val date = ds(0)
      val min = ds(2)

      val begin = " Guard #([0-9]+) begins shift".r
      val wake = " wakes up".r
      val sleep = " falls asleep".r

      val state = e match {
	      case begin(n) => Right(n)
	      case wake() => Left(true)
	      case sleep() => Left(false)
      }
      (state.isRight, (state, date, min))
      }

    val joined = joinGuard(formatted.toList)

    val clean = joined.map{_.map { case (a,b,c) => (a,c.toInt) }}
    val mapped = clean.map(toIntArr(_)).toArray
    // showMat(mapped)
    // row, col
    // println(mapped(0)(5))

    showMat(mapped)
    val guards = clean.map(_(0)._1.right.get)
    // val guardToArray = guards.zip(mapped)
    // sleepPerGuard.foreach(_.foreach(println))



    val minutesPerNight = mapped.map(_.reduce(_ + _))
    val lazyGuard = sleepyGuard(mapped)
    val guardMap = guards.zipWithIndex
    val id = guardMap.filter(_._2 == lazyGuard).head._1
    val indices = guardMap.map(_._1 == id)
    val maxMin = maxGuardMinute(mapped, indices.toArray)
    // .. indices.foreach(println)
    println(maxMin._2 * id.toInt)
    // val lazyId =
    // val sleepArray = guards.zip(mapped).groupBy(_._1).mapValues(_.map(_._2))(lazyGuard).toArray.transpose.map(_.reduce(_ + _))
    // val maxIndex = sleepArray.zip(0 to 59).max._2
    // println(maxIndex.toLong * lazyGuard.toLong)

// println(maxIndex + 3)


	    // commonMin.map(print)
	    //println(commonMin)
	    // println(lazyGuard)

	    // maxSleep.foreach(println)

      // .indices.maxBy(list)
      // val id = 
	    // val max = guards.zip(mapped) // .groupBy(_._1).mapValues(.map(_.reduce(_ + _)).sum)
    }
}


// not 53979
// val guards = clean.map(_(0)._1.right.get)
// val minutesPerNight = mapped.map(_.reduce(_ + _))
// val lazyGuard = guards.zip(minutesPerNight).groupBy(_._1).mapValues(_.map(_._2).sum).map(_.swap).max._2
// val sleepArray = guards.zip(mapped).groupBy(_._1).mapValues(_.map(_._2))(lazyGuard).toArray.transpose.map(_.reduce(_ + _))
// val maxIndex = sleepArray.zip(0 to 59).max._2
// println(maxIndex.toInt * lazyGuard.toInt)
