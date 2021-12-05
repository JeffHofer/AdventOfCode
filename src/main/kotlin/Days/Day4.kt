package Days

import Bingo.BingoGame
import Bingo.Board
import Bingo.Cell

class Day4: Day{
    override var DAY = 4

    override fun challenge1(): Int {
        var bingoGame = buildBingoGame("input4.txt")
        var winningBoard = bingoGame.determineWinner()
        return winningBoard.getScore(bingoGame.lastCalled);
    }

    override fun challenge2(): Int {
        var bingoGame = buildBingoGame("input4.txt")
        var losingBoard = bingoGame.determineLoser()
        return losingBoard.getScore(bingoGame.lastCalled);
    }

    private fun buildBingoGame(path: String): BingoGame{
        var fileContent = FileReader.readResource(path, "\n\n")

        //You can take the developer out of the Java, but you can't take the Java out of the developer
        var callNumbers = fileContent[0].split(',').map { it.toInt() }

        var boards = mutableListOf<Board>()

        for(i in 1..fileContent.size -1) { //Each index is a board
            var valueList  = fileContent[i].stripLeading().split("\\s+".toRegex())
            var cells = mutableListOf<Cell>()
            //Each group of five lines is a board
            valueList.forEachIndexed { index, it ->
                cells.add(Cell(index % 5, index / 5, Integer.parseInt(it)))
            }
            boards.add(Board(cells.toTypedArray()))
        }
        return BingoGame(callNumbers, boards)
    }
}