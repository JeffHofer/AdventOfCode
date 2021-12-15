package Days

import java.util.*
import kotlin.collections.ArrayList

class Day13:Day {
    var dots: ArrayList<ArrayList<Int>> = arrayListOf()
    var instructions: ArrayList<ArrayList<Int>> = arrayListOf()
    override val DAY = 13

    override fun challenge1(): Long {
        readPage()
        fold(instructions[0])
        return dots.size.toLong()
    }

    override fun challenge2(): Long {
        instructions.forEach{
            fold(it)
        }
        printDots()
        return 0
    }

    private fun readPage() {
        var fileContent = FileReader.readResource("input13.txt")
        fileContent.forEach {
            if(it.contains(Regex("fold"))){ //instruction
                var split = it.split('=')
                var axis: Int
                if(split[0].last() == 'x')
                    axis = 0
                else
                    axis = 1
                instructions.add(arrayListOf(axis, split[1].toInt()))
            } else if(it.contains(Regex(".|#"))){
                dots.add(ArrayList(it.split(',').map { it.toInt() }))
            }
        }
    }

    private fun fold(fold: ArrayList<Int>) {
        var foldLine = fold[1]
        var foldAxis = fold[0]
        var newDots: ArrayList<ArrayList<Int>> = arrayListOf()
        dots.forEach{
            if(it[foldAxis] < foldLine){
                if(!newDots.contains(it)) newDots.add(it)
            }else {
                it[foldAxis] = foldLine - (it[foldAxis] - foldLine)
                if(!newDots.contains(it)) newDots.add(it)
            }
        }
        dots = ArrayList(newDots)
    }

    private fun printDots(){
        var maxX = 0
        var maxY = 0
        dots.forEach{
            if(it[0] > maxX)
                maxX = it[0]
            if(it[1] > maxY)
                maxY = it[0]
        }
        var matrix = Array<Array<Char>>(maxY+1){ Array<Char>(maxX+1) { '.'} }
        dots.forEach{
            matrix[it[1]][it[0]] = '#'
        }
        matrix.forEach { println(Arrays.toString(it)) }
    }
}