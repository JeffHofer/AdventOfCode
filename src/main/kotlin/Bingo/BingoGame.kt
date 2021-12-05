package Bingo

class BingoGame(numbers: List<Int>, boards: List<Board>) {
    var boards = boards
    var numbers = numbers
    var lastCalled: Int = -1

    fun determineWinner(): Board {
        numbers.forEach{ num ->
            lastCalled = num
            boards.forEach { board ->
                if(board.callNumber(num)) {
                    return board
                }
            }
        }
        throw Exception()
    }

    fun determineLoser(): Board {
        var stillPlaying = boards.toMutableList()
        numbers.forEach{ num ->
            lastCalled = num
            val boardchecker =  stillPlaying.iterator()
            while(boardchecker.hasNext()) {
                val board = boardchecker.next()
                if(board.callNumber(num)) {
                    if(stillPlaying.size == 1) return board
                    boardchecker.remove()
                }
            }
        }
        throw Exception()
    }
}