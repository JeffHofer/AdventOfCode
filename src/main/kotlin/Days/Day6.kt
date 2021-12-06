package Days

class Day6: Day {
    override var DAY = 6

    override fun challenge1(): Long {
        var fish = getFishFromInput()
        return passTime(80, fish)
    }

    override fun challenge2(): Long {
        var fish = getFishFromInput()
        return passTime(256, fish)
    }

    private fun getFishFromInput(): Array<Long> {
        var fileContent = FileReader.readResource("input6.txt")
        var ages = fileContent[0].split(',').map { Integer.parseInt(it) }
        var fishPerDay: Array<Long> = Array(9) { 0 }
        ages.forEach {
            fishPerDay[it] ++
        }
        return fishPerDay
    }

    fun passTime(days: Int, startingCounts: Array<Long>): Long{
        var currentCounts = startingCounts
        for( i in 1..days ) {
            var nexDay: Array<Long> = Array(9) { 0 }
            for( i in 0..8) {
                if(i == 0){
                    nexDay[6] += currentCounts[i]
                    nexDay[8] += currentCounts[i]
                } else {
                    nexDay[i-1] += currentCounts[i]
                }
            }
            currentCounts = nexDay.clone()
        }
        var count: Long = 0
        currentCounts.forEach {
            count += it
        }
        return count
    }
}