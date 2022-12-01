package Bingo

class Cell(x: Int, y: Int, value: Int) {
    var value = value
    var marked = false
    var x = x
    var y = y

    fun mark() {
        marked = true
    }

    override fun toString(): String {
        return "" + value + " [" + x + ", " + y + "]"
    }

}