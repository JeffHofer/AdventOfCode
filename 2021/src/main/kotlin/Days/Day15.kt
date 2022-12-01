package Days

class Day15:Day {
    override val DAY = 15

    var map: ArrayList<ArrayList<Int>> = arrayListOf()

    override fun challenge1(): Long {
        readMap()
        var lowestRisk = findLowestRiskPath(arrayListOf(arrayListOf(0,0)))
        println(lowestRisk)
        return 0
    }

    override fun challenge2(): Long {
        return 0
    }

    fun readMap(){
        map = arrayListOf()
        var fileContent = FileReader.readResource("input15test.txt")
        fileContent.forEach {
            map.add(ArrayList(it.toList().map { it.digitToInt()}))
        }
    }

    fun findLowestRiskPath(pvisited: ArrayList<ArrayList<Int>>): Int{
        var visited = pvisited

        while (!visited.contains(arrayListOf(map.size -1, map[0].size-1))) {
            println(visited)
            var startPoint = visited.last()
            var nextVisited = arrayListOf<ArrayList<Int>>()
            getAdjacent(startPoint[0], startPoint[1]).forEach {
                if(!visited.contains(it)) {
                    var newVisited = ArrayList(visited)
                    newVisited.add(it)
                    var cost = getCost(newVisited)
                    if(nextVisited.isEmpty() || cost < getCost(nextVisited)){
                        nextVisited = ArrayList(newVisited)
                    }
                }
            }
            visited = ArrayList(nextVisited)
        }
        return getCost(visited)
    }

    private fun getAdjacent(row: Int, col: Int): ArrayList<ArrayList<Int>>{
        var adjacent = arrayListOf<ArrayList<Int>>()
        if (row < map.size -1) adjacent.add(arrayListOf(row + 1, col))
        if (col < map[row].size -1) adjacent.add(arrayListOf(row, col + 1))
        if (row > 0) adjacent.add(arrayListOf(row -1, col))
        if (col > 0) adjacent.add(arrayListOf(row, col -1))
        return adjacent
    }

    private fun getCost(path: ArrayList<ArrayList<Int>>): Int {
        var cost = 0;
        path.forEach{
            cost += map[it[0]][it[1]]
        }
        return cost
    }
}