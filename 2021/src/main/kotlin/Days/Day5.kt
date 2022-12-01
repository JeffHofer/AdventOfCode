package Days

import Graph.Line
import java.util.*

class Day5: Day {
    override var DAY = 5

    override fun challenge1(): Long {
        var lines = getLines()
        var graph = plotLines(lines)
        return countIntersections(graph).toLong()
    }

    override fun challenge2(): Long {
        var lines = getLines(false)
        var graph = plotLines(lines)
        return return countIntersections(graph).toLong()
    }

    private fun getLines(ignoreDiagonal: Boolean = true): List<Line> {
        var fileContent = FileReader.readResource("input5.txt")
        var keepLines = mutableListOf<Line>()

        fileContent.forEachIndexed { index, it ->
            var coords = it.split(" -> ").map { it.split(',').map { Integer.parseInt(it) } }
            var line = Line(coords[0], coords[1])
            if ((!line.isDiagonal && ignoreDiagonal) || !ignoreDiagonal) {
                keepLines.add(Line(coords[0], coords[1]))
            }
        }
        return keepLines
    }

    private fun plotLines(lines: List<Line>): Array<Array<Int>> {
        var graph = Array(1000) { Array(1000) {0} }
        lines.forEach { line ->
            line.pointsCovered.forEach { point ->
                graph[point[0]][point[1]]++
            }
        }
        return graph
    }

    private fun printGraph(graph: Array<Array<Int>>) {
        graph.forEach {
            println(Arrays.toString(it))
        }
    }

    private fun countIntersections(graph: Array<Array<Int>>): Int {
        var count = 0
        graph.forEach { xValue ->
            xValue.forEach { yValue ->
                if(yValue > 1) count ++
            }
        }
        return count
    }
}