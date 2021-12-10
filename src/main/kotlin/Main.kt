import Days.*
import java.util.*

fun main(args: Array<String>) {
//    evaluateDay(Day1())
//    evaluateDay(Day2())
//    evaluateDay(Day3())
//    evaluateDay(Day4())
//    evaluateDay(Day5())
//    evaluateDay(Day6())
//    evaluateDay(Day7())
//    evaluateDay(Day8())
//    evaluateDay(Day9())
    evaluateDay(Day10())
}

fun evaluateDay(day: Day){
    println("Evaluating Day" + day.DAY)

    println("First challenge solution: " + day.challenge1())
    println("Second challenge solution: " + day.challenge2())
}