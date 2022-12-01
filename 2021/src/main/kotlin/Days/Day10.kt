package Days

import java.util.*
import kotlin.collections.ArrayList

class Day10: Day {
    override val DAY = 10

    val illegalCharScores: Map<Char, Int> = mapOf(')' to 3, ']' to 57, '}' to 1197, '>' to 25137)
    val autocompleteScores: Map<Char, Int> = mapOf(')' to 1, ']' to 2, '}' to 3, '>' to 4)
    val pairs: Map<Char, Char> = mapOf('(' to ')', '[' to ']', '{' to '}', '<' to '>')
    val openingBrackets = arrayListOf('(', '{', '[', '<')

    override fun challenge1(): Long {
        var score = 0
        getInstructions().forEach {
            score += getFirstIllegalCharScore(it)
        }
        return score.toLong()
    }

    override fun challenge2(): Long {
        var scores = arrayListOf<Long>()
        getInstructions().forEach{
            if(getFirstIllegalCharScore(it) == 0) {
                scores.add(getMissingCharScore(it))
            }
        }
        return scores.sorted()[(scores.size) /2]
    }

    fun getInstructions(): ArrayList<CharArray> {
        var fileContent = FileReader.readResource("input10.txt")
        return ArrayList(fileContent.map { it.toCharArray() })
    }

    fun getFirstIllegalCharScore(instruction: CharArray): Int {
        var bracketTracker = Stack<Char>()
        instruction.forEach {
            if(openingBrackets.contains(it)) {
                bracketTracker.push(it)
            } else {
                var open = bracketTracker.pop()
                if(!((it == ')' && open == '(') ||
                        (it == ']' && open == '[') ||
                        (it == '}' && open == '{') ||
                        (it == '>' && open == '<'))) {
                    return illegalCharScores.get(it) ?: 0;
                }
            }
        }
        return 0
    }

    fun getMissingCharScore(instruction: CharArray): Long {
        var bracketTracker = Stack<Char>()
        instruction.forEach {
            if (openingBrackets.contains(it)) {
                bracketTracker.push(it)
            } else {
                bracketTracker.pop()
            }
        }
        var score: Long = 0
        bracketTracker.map { pairs.get(it) ?: '_' }.toCharArray().reversedArray().forEach {
            score = (score * 5) + (autocompleteScores.get(it) ?: 0)
        }
        return score
    }
}