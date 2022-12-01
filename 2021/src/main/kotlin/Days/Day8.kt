package Days

import FileReader

class Day8: Day {
    override val DAY = 8

    override fun challenge1(): Long {
        var input = getInput()
        var count = 0
        input.forEach {
            var inputSignals = it.split(" | ")[0]
            var outputSignals = it.split(" | ")[1]
            var decodedInputSignals = decodeInputSignals(inputSignals)
            var decodedOutputSignals = decodeOutputSignals(decodedInputSignals, outputSignals)
            decodedOutputSignals.forEach {
                if(it == 1 || it == 4 || it ==7 || it == 8) count ++
            }
        }
        return count.toLong()
    }

    override fun challenge2(): Long {
        var input = getInput()
        var total: Long = 0
        input.forEach {
            var inputSignals = it.split(" | ")[0]
            var outputSignals = it.split(" | ")[1]
            var decodedInputSignals = decodeInputSignals(inputSignals)
            var decodedOutputSignals = decodeOutputSignals(decodedInputSignals, outputSignals)
            total += decodedOutputSignals.joinToString(separator = "").toLong()
        }
        return total
    }

    fun getInput(): List<String>{
        return FileReader.readResource("input8.txt")
    }

    fun decodeInputSignals(inputSignals: String): Array<MutableList<Char>>{
        var inputSignalList = inputSignals.split(' ').map{ it.toList() }.sortedBy { it.size }
        var identifiedSignals = Array(10) { mutableListOf<Char>()}

        //Numbers with unique signal lengths: 1, 4, 7, 8
        identifiedSignals[1] = getElementOfSize(inputSignalList, 2)
        identifiedSignals[4] = getElementOfSize(inputSignalList, 4)
        identifiedSignals[7] = getElementOfSize(inputSignalList, 3)
        identifiedSignals[8] = getElementOfSize(inputSignalList, 7)

        //Determine the signal for 9
        //9 is the only 6 element signal to contain all elements of 4
        inputSignalList.forEach {
            if(it.size == 6){
                var candidate = true
                identifiedSignals[4].forEach { element ->
                    if(!it.contains(element)) candidate = false
                }
                if (candidate)identifiedSignals[9] = it.toMutableList()
            }
        }

        //Determine the signal for 0
        //0 contains 7 and isn't 4
        inputSignalList.forEach {
            if(it.size == 6){
                var candidate = true
                identifiedSignals[7].forEach { element ->
                    if(!it.contains(element)) candidate = false
                }
                if (candidate && it != identifiedSignals[9]) identifiedSignals[0] = it.toMutableList()
            }
        }

        //determine the signal for
        //only remaining 5 element signal
        inputSignalList.forEach {
            if(it.size == 6 && it != identifiedSignals[9] && it != identifiedSignals[0]){
                identifiedSignals[6] = it.toMutableList()
            }
        }

        //determine signal for 3
        //only 5 element signal to contain 7
        inputSignalList.forEach {
            if(it.size == 5){
                var candidate = true
                identifiedSignals[7].forEach { element ->
                    if(!it.contains(element)) candidate = false
                }
                if (candidate)identifiedSignals[3] = it.toMutableList()
            }
        }

        //Determine signal for 2
        //Only 5 element signal that contains the only element that is in 8 but not 9
        identifiedSignals[8].forEach {
            if(!identifiedSignals[9].contains(it)) {
                inputSignalList.forEach { signal ->
                    if (signal.size == 5 && signal.contains(it) && signal != identifiedSignals[3]) {
                        identifiedSignals[2] = signal.toMutableList()
                    }
                }
            }
        }

        //determine signal for 5
        //only remaining 5 element signal
        inputSignalList.forEach {
            if(it.size == 5 && it != identifiedSignals[2] && it != identifiedSignals[3]){
                identifiedSignals[5] = it.toMutableList()
            }
        }

        return identifiedSignals
    }

    fun decodeOutputSignals(inputSignals: Array<MutableList<Char>>, outputSignals: String): List<Int>{
        var outputSignalList = outputSignals.split(' ').map{ it.toList() }
        var outputSignals = mutableListOf<Int>()

        var identifiedSignals =  mutableListOf<Int>()

        outputSignalList.forEach { output ->
            inputSignals.forEachIndexed { index, input ->
                if (output.sorted() == input.sorted()) identifiedSignals.add(index)
            }
        }

        return identifiedSignals
    }

    //assumes you're looking for an element of a unique size
    private fun getElementOfSize(list: List<List<Char>>, size: Int): MutableList<Char> {
        list.forEach {
            if(it.size == size) return it.toMutableList()
        }
        return mutableListOf()
    }
}