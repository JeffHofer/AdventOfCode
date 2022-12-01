package Days

class Day7: Day {
    override val DAY = 7

    override fun challenge1(): Long {
        var crabLocations = getCrabLocations()
        return calculateOptimalFuel(crabLocations).toLong()
    }

    override fun challenge2(): Long {
        var crabLocations = getCrabLocations()
        return calculateOptimalFuel(crabLocations, true).toLong()
    }

    private fun getCrabLocations(): List<Int>{
        var fileContent = FileReader.readResource("input7.txt")
        return fileContent[0].split(',').map { Integer.parseInt(it) }
    }

    private fun calculateOptimalFuel(crabLocations: List<Int>, nonLinearBurn: Boolean = false): Int {
        var fuelToOptimal: Int? = null
        val min = crabLocations.minOrNull() ?: 0
        val max = crabLocations.maxOrNull() ?: 0
        for(i in min .. max){
            var totalFuelToCurrent = 0
            crabLocations.forEach {
                totalFuelToCurrent += calculateFuelBurn(Math.abs(it-i), nonLinearBurn)
            }
            if((fuelToOptimal == null) || totalFuelToCurrent < fuelToOptimal) fuelToOptimal = totalFuelToCurrent
        }
        return fuelToOptimal ?: 0
    }

    private fun calculateFuelBurn(distance: Int, nonLinearBurn: Boolean): Int {
        if(!nonLinearBurn) return distance
        var total = 0
        for(i in 1..distance){
            total += i
        }
        return total
    }
}