package Days

import FileReader

class Day1 {
    fun challenge1(): Int {
        val depths = getDepths()
        return findIncrease(depths);
    }

    fun challenge2(): Int {
        val depths = getDepths()
        val windows = splitIntoWindows(depths)
        return findIncrease(windows);
    }

    private fun getDepths(): MutableList<Int> {
        val depths = mutableListOf<Int>()
        var fileReader = FileReader()
        val fileContent = fileReader.readResource("input1.txt")
        fileContent.forEach{depths.add(Integer.parseInt(it))}
        return depths;
    }

    private fun findIncrease(depths: MutableList<Int>): Int {
        var count = 0;
        for(i in 1..depths.size-1){
            if(depths.get(i) > depths.get(i-1)){
                count++;
            }
        }
        return count;
    }

    private fun splitIntoWindows(list: MutableList<Int>): MutableList<Int> {
        var windows = mutableListOf<Int>()
        for (i in 0..list.size-3){
            windows.add(list.get(i) + list.get(i+1) + list.get(i+2))
        }
        return windows;
    }
}