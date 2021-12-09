package Days

import kotlin.collections.ArrayList

class Day9: Day {
    override val DAY = 9

    override fun challenge1(): Long {
        var map = getMap()
        var lowSpots = findLowSpots(map)
        return totalRiskLevel(lowSpots).toLong()
    }

    override fun challenge2(): Long {
        var map = getMap()
        var lowSpots = findLowSpots(map)
        lowSpots.sortByDescending { it[1] }
        return (lowSpots[0][1] * lowSpots[1][1] * lowSpots[2][1]).toLong()
    }

    private fun getMap(): ArrayList<ArrayList<Int>> {
        var map = arrayListOf<ArrayList<Int>>()
        var fileContent = FileReader.readResource("input9.txt")
        fileContent.forEach {
            map.add(ArrayList(it.toList().map { value -> value.digitToInt()}))
        }
        return map
    }

    //returns just the values of the low spots, not the locations
    private fun findLowSpots(map: ArrayList<ArrayList<Int>>): ArrayList<ArrayList<Int>> {
        var lowSpots = arrayListOf<ArrayList<Int>>()
        map.forEachIndexed { rowNum, row ->
            row.forEachIndexed { colNum, height ->
                var coordsToCheck = determineCoordsToCheck(map, rowNum, colNum)
                var lowSpot = true
                coordsToCheck.forEach{ coord ->
                    if(height >= map[coord[0]][coord[1]]) lowSpot = false
                }
                //For each low spot, also find the size of the basin it sits in
                if(lowSpot){
                    var basin = arrayListOf(arrayListOf(rowNum, colNum))
                    var prevBasinSize = 0
                    while(basin.size != prevBasinSize) {
                        prevBasinSize = basin.size
                        var nextBasin = ArrayList(basin)
                        basin.forEach{ inBasin ->
                            determineCoordsToCheck(map, inBasin[0], inBasin[1]).forEach { adjacent ->
                                if(map[adjacent[0]][adjacent[1]] != 9 && !basin.contains(adjacent) && !nextBasin.contains(adjacent))
                                    nextBasin.add(adjacent)
                            }
                        }
                        basin = ArrayList(nextBasin)
                    }
                    lowSpots.add(arrayListOf(height, basin.size))
                }
            }
        }
        return lowSpots
    }

    private fun determineCoordsToCheck(map: ArrayList<ArrayList<Int>>, rowNum: Int, colNum: Int): ArrayList<ArrayList<Int>>{
        var coordsToCheck = arrayListOf<ArrayList<Int>>()
        if (rowNum > 0) coordsToCheck.add(arrayListOf(rowNum -1, colNum))
        if (rowNum < map.size -1) coordsToCheck.add(arrayListOf(rowNum + 1, colNum))
        if (colNum > 0) coordsToCheck.add(arrayListOf(rowNum, colNum -1))
        if (colNum < map[rowNum].size -1) coordsToCheck.add(arrayListOf(rowNum, colNum + 1))
        return coordsToCheck
    }

    private fun totalRiskLevel(lowSpots: ArrayList<ArrayList<Int>>): Int {
        return lowSpots.map { it[0] + 1 }.sum()
    }

}