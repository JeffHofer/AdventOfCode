package Days

import octopus.Octopus

class Day11: Day {
    override val DAY = 11
    var octopi:ArrayList<Octopus> = arrayListOf()

    override fun challenge1(): Long {
        initOctopi()
        return step(100).toLong()
    }

    override fun challenge2(): Long {
        initOctopi()
        return findSync().toLong()
    }

    fun initOctopi() {
        var fileContent = FileReader.readResource("input11.txt")
        octopi.clear()
        fileContent.forEachIndexed { x, line ->
            line.toCharArray().map { it.digitToInt() }.forEachIndexed { y, lvl ->
                octopi.add(Octopus(lvl, x, y))
            }
        }
    }

    private fun step(steps: Int): Int {
        var flashedTotal = 0
        for (i in 1..steps) {
            incrementAllOctopi()
            var flashed = 0
            var prevFlash = -1
            while(flashed != prevFlash){
                prevFlash = flashed
                octopi.forEach{
                    if(it.level > 9 && !it.flashed) {
                        flashed ++
                        flash(it)
                    }
                }
            }
            flashedTotal += flashed
            resetFlashed()
        }
        return flashedTotal
    }

    private fun findSync(): Int {
        var flashed = 0
        var steps = 0
        while (flashed != octopi.size) {
            flashed = 0
            steps ++
            incrementAllOctopi()
            var prevFlash = -1
            while(flashed != prevFlash){
                prevFlash = flashed
                octopi.forEach{
                    if(it.level > 9 && !it.flashed) {
                        flashed ++
                        flash(it)
                    }
                }
            }
            resetFlashed()
        }
        return steps
    }

    private fun incrementAllOctopi() {
        octopi.forEach{
            it.level ++
        }
    }

    private fun flash(octopus: Octopus) {
        octopus.flashed = true
        octopi.forEach{
            if((Math.abs(it.x-octopus.x) <= 1) && (Math.abs(it.y-octopus.y) <= 1))
                it.level++
        }
    }

    private fun resetFlashed(){
        octopi.forEach {
            it.flashed = false
            if(it.level > 9) it.level = 0
        }
    }
}