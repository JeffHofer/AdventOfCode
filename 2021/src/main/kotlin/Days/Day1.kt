package Days

import FileReader

class Day1: Day {
    override val DAY = 1

    override fun challenge1(): Long {
        val depths = getDepths()
        return findIncrease(depths).toLong();
    }

    override fun challenge2(): Long {
        val depths = getDepths()
        val windows = splitIntoWindows(depths)
        return findIncrease(windows).toLong();
    }

    private fun getDepths(): MutableList<Int> {
        val depths = mutableListOf<Int>()
        val fileContent = FileReader.readResource("input1.txt")
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