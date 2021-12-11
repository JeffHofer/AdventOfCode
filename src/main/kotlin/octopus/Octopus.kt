package octopus

class Octopus(level: Int, x: Int, y: Int) {
    var level = level
    var x = x
    var y = y
    var flashed = false

    override fun toString(): String {
        return "$level [$x, $y]"
    }
}