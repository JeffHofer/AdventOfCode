package Bingo

class Board(cells: Array<Cell>) {
    var cells: Array<Cell> = cells

    //Boolean indicates if the called number results in a bingo
    fun callNumber(number: Int): Boolean {
        cells.forEach {
            if(it.value == number) it.mark()
        }
        return isWinner()
    }

    fun getScore(lastCalled: Int): Int {
        var unmarkedTotal = 0
        cells.forEach {
            if(!it.marked) {
                unmarkedTotal += it.value
            }
        }
        return unmarkedTotal * lastCalled
    }

    //A winning board has 5 marked cells with the same x, 5 marked cells with the same y
    fun isWinner(): Boolean {
        for(i in 0..4){
            if(checkCol(i) || checkRow(i)) {
                return true
            }
        }
        return false
    }
    
    fun printBoard(){
        var count = 0
        cells.forEachIndexed { index, cell ->
            count += 1
            print("" + cell.value)
            if(cell.marked) print("*")
            print(" ")
            if(count ==5) {
                print('\n')
                count = 0
            }
        }
    }

    private fun checkCol(x: Int): Boolean {
        cells.forEach {
            if(!it.marked && it.x == x){
                return false
            }
        }
        return true
    }

    private fun checkRow(y: Int): Boolean {
        cells.forEach {
            if(!it.marked && it.y == y){
                return false
            }
        }
        return true
    }


}