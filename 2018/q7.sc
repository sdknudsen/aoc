import scala.io.Source
import scala.collection.mutable.PriorityQueue
import scala.collection.mutable.Set

object q {
  var seen: Set[Char] = Set()

  val r = "Step ([A-Z]) must be finished before step ([A-Z]) can begin.".r
  var currTime = 0

  def getFirst(xs : List[(Char, Char)]): scala.collection.immutable.Set[Char] = {
    val fst = xs.map(_._1).toSet
    val snd = xs.map(_._2).toSet
    fst -- snd
  }

  def getPairs(s: String) = s match {
    case r(a,b) => (a(0),b(0))
  }

  def adj(x: Char, m: Map[Char, List[Char]]) = if(m isDefinedAt x) m(x) else List()

  def isUnlocked(x: Char, parents: Map[Char, List[Char]]): Boolean = (adj(x, parents).toSet -- seen).isEmpty

  def existsFreeWorker(qs: Array[PriorityQueue[Char]]): Int = {
    for(i <- qs.length) {
      if(qs(i).head <= currTime)
        qs(i).dequeue
    }
    for(i <- qs.length) {
      if(!qs(i).isEmpty)
        return i
    }
    -1
  }

  def traverse(qs: Array[PriorityQueue[Char]],
               children: Map[Char, List[Char]],
               parents: Map[Char, List[Char]]): Unit = {
    currTime += 1

    val freeWorker = existsFreeWorker(qs)
    if(freeWorker == -1) {
      traverse(qs, children, parents)
    }

    else {
      val q = qs(freeWorker)
      if(!q.isEmpty) {
        val curr = q.dequeue
        seen += curr
        print(curr)
        currTime += 1

        adj(curr, children).foreach{ x =>

          if(isUnlocked(x, parents))
            q += x
        }
        traverse(qs, children, parents)
      }
    }
  }

  def main(args: Array[String]) = {
    val arr = Source.fromFile("/home/sknudsen/Desktop/q7input").getLines.toArray.toList
    // val arr = Source.fromFile("/home/sknudsen/Desktop/q7t").getLines.toArray.toList
    val pairs = arr.map(getPairs).+:(('!','!'))
    val m = pairs.groupBy(_._1).mapValues(_.map(_._2).sorted)
    val parents = pairs.map(_.swap).groupBy(_._1).mapValues(_.map(_._2))
    val begin = getFirst(pairs).toList
    val qCount = 2

    // val qs: Array[PriorityQueue[Char]] = Array.fill(qCount)( new [PriorityQueue[Char]])
    val qs = Array.fill[PriorityQueue[Char]](qCount)(PriorityQueue()(implicitly[Ordering[Char]].reverse))
    for(i <- 0 until begin.length)
      qs(i % begin.length) += begin(i)

    traverse(qs, m, parents)
  }
}
