package Graph

class Line(start: List<Int>, end: List<Int>) {
    var startCoords: List<Int>
    var endCoords: List<Int>

    var pointsCovered: List<List<Int>>
    var isDiagonal: Boolean

    init {
        startCoords = start
        endCoords = end
        isDiagonal = !(startCoords[0] == endCoords[0] || startCoords[1] == endCoords[1])
        pointsCovered = determinePointsCovered()
    }

    private fun determinePointsCovered(): List<List<Int>>{
        var pointsCovered = mutableListOf<List<Int>>()

        var yDifference = endCoords[1] - startCoords[1]
        var xDifference = endCoords[0] - startCoords[0]

        var lineLength = maxOf(Math.abs(yDifference), Math.abs(xDifference))

        var yRateOfChange = yDifference/lineLength
        var xRateOfChange = xDifference/lineLength

        var x = startCoords[0]
        var y = startCoords[1]
        var reachedEnd = false
        while(!reachedEnd){
            if(x == endCoords[0] && y == endCoords[1]) reachedEnd = true
            pointsCovered.add(listOf(x, y))
            x += xRateOfChange
            y += yRateOfChange
        }
        return pointsCovered.toList()
    }
}