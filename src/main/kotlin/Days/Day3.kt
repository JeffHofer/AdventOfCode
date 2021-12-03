package Days

import FileReader
import java.util.*
import kotlin.math.pow

class Day3 {
    fun challenge1(): Int {
        var mostCommon = getMostCommon(getBinaryList())
        var gammaRate = getGammaRate(mostCommon)
        var epsilonRate = getEpsilonRate(mostCommon)
        return gammaRate * epsilonRate
    }

    fun challenge2(): Int {
        var binaryList = getBinaryList()
        var ogr = evaluateBitCriteria(binaryList, true)
        var c2r= evaluateBitCriteria(binaryList, false)
        return ogr*c2r
    }

    private fun getBinaryList():List<String> {
        var fileReader = FileReader()
        return fileReader.readResource("input3.txt")
    }

    private fun getMostCommon(binaryList: List<String>):String{
        // Tracks the weight of each digit
        // Negative weight = 0, Positive weight = 1
        var weightByDigit:Array<Int> = arrayOf(0,0,0,0,0,0,0,0,0,0,0,0)
        binaryList.forEach{
            for(i in 0..11){
                if(it.get(i).equals('1')){
                    weightByDigit[i] += 1
                } else {
                    weightByDigit[i] -= 1
                }
            }
        }
        var mostCommon: String = ""
        weightByDigit.forEach {
            if(it > 0){
                mostCommon += "1"
            } else {
                mostCommon += "0"
            }
        }
        return mostCommon
    }

    private fun evaluateBitCriteria(binaryList: List<String>, commonMatches: Boolean): Int{
        var currentStringSet: MutableList<String> = binaryList.toMutableList()
        for(i in 0..11) {
            if(currentStringSet.size == 1) break

            var mostCommon: Char = '0'
            var weight = 0;

            currentStringSet.forEach {
                if(it.get(i) == '1') weight += 1  else weight -= 1
            }

            if (weight >= 0 ) mostCommon = '1'

            var nextStringSet: MutableList<String> = mutableListOf()
            for (j in 0..currentStringSet.size - 1) {
                if ((currentStringSet[j].get(i) == mostCommon && commonMatches) || (currentStringSet[j].get(i) != mostCommon && !commonMatches))  {
                    nextStringSet.add(currentStringSet[j])
                }
            }
            currentStringSet = nextStringSet
        }
        return binaryStringToDecimal(currentStringSet[0])
    }

    private fun getGammaRate(mostCommon: String): Int {
        return binaryStringToDecimal(mostCommon)
    }

    private fun getEpsilonRate(mostCommon: String):Int {
        return binaryStringToDecimal(invertBinaryString(mostCommon))
    }

    private fun binaryStringToDecimal(binaryString: String): Int {
        var decimalValue = 0
        var power = 0
        for(i in binaryString.length -1 downTo 0){
            decimalValue += Integer.parseInt(binaryString.get(i).toString()) * 2.0.pow(power).toInt()
            power ++
        }
        return decimalValue
    }

    private fun invertBinaryString(binaryString: String): String {
        var inverted: String = ""
        for(i in 0..binaryString.length-1){
            if(binaryString.get(i) == '0') {
                inverted += "1"
            } else {
                inverted += "0"
            }
        }
        return inverted
    }
}