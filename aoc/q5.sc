import scala.io.Source

object q {

  def differ(a: Char, b: Char) : Boolean = {
    (a - b).abs == 32
    // (('a' to 'z').contains(a) && ('A' to 'Z').contains(b))
    // ||
    // (('a' to 'z').contains(b) && ('A' to 'Z').contains(a))
  }

  var n = 0

  def translate(xs: List[Char], ys: List[Char]) : List[Char] = xs match {

	  case x :: y :: tail =>
      if(differ(x,y)) {
        n += 1
        translate(tail,ys)
      }
      else
        translate(y :: tail, x::ys)

	  case x :: tail =>
      translate(tail, x::ys)
    case Nil => ys
  }

  def main(args: Array[String]) = {
    val arr = Source.fromFile("/home/sknudsen/Desktop/q5input").getLines.toArray.head.toCharArray.toList
    // val arr = "dabAcCaCBAcCcaDA".toCharArray.toList
    // println(arr)

    var min = 10888
    for(letter <- 'a' to 'z') {

      var ls = arr.filter(x => (x != letter) && (x != (letter - 32)))
      // println(ls.toArray.toString)
      var prevSize = 0
      while(prevSize != ls.length) {
        prevSize = ls.length
        ls = translate(ls, Nil)
        min = Integer.min(min, ls.length)
      }

      // println(letter)
      // println(ls.length)
      // println()
      // println(n)
    }
    println(min)
  }
}
