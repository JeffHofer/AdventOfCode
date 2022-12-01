package Days

class Day14: Day {
    override val DAY = 14
    var rules: ArrayList<Rule> = arrayListOf()
    var pairs: MutableMap<String, Long> = mutableMapOf()
    var letters: MutableMap<String, Long> = mutableMapOf()

    override fun challenge1(): Long {
        readInstructions()
        for(i in 1..10)
            step()


        var mostCommon = letters.maxByOrNull { it.value }?.value
        var leastCommon =  letters.minByOrNull { it.value }?.value
        return ((mostCommon ?: 0) - (leastCommon ?:0))
    }

    override fun challenge2(): Long {
        readInstructions()
        for(i in 1..40)
            step()

        var mostCommon = letters.maxByOrNull { it.value }?.value
        var leastCommon =  letters.minByOrNull { it.value }?.value
        return ((mostCommon ?: 0) - (leastCommon ?:0))
    }

    private fun readInstructions(){
        rules = arrayListOf()
        pairs = mutableMapOf()
        letters = mutableMapOf()
        var fileContent = FileReader.readResource("input14.txt")
        fileContent.forEachIndexed { index, it ->
            if(index == 0){
                var asList = ArrayList(it.toList().map { it.toString() })
                asList.forEach{
                    letters[it] = (letters[it] ?: 0) +1
                }
                for( i in 0..asList.size -1) {
                    if(i+1 < asList.size){
                        var pair = "${asList[i]}${asList[i+1]}"
                        pairs[pair] = (pairs[pair] ?: 0) + 1
                    }
                }
            }
            if(index > 1){
                var split = it.split(" -> ")
                rules.add(Rule(split[0], split[1]))
            }
        }

    }
    private fun step(){
        var newPairs: MutableMap<String, Long> = mutableMapOf()
        pairs.forEach{
            if(rulesContains(it.key)){
                var insert = lookupInsert(it.key)
                letters[insert] = (letters[insert] ?: 0) + (pairs[it.key] ?: 0)
                var pair1 = "${it.key[0]}${insert}"
                var pair2 = "${insert}${it.key[1]}"
                newPairs.put(pair1, (pairs[it.key] ?: 0) + (newPairs[pair1] ?: 0))
                newPairs.put(pair2, (pairs[it.key] ?: 0) + (newPairs[pair2] ?: 0))
            }else{
                newPairs.put(it.key, (newPairs[it.key] ?: 0) + 1)
            }
        }
        pairs = newPairs
    }

    private fun rulesContains(pair: String): Boolean {
        rules.forEach{
            if(it.pair == pair){
                return true
            }
        }
        return false
    }

    private fun lookupInsert(pair: String): String {
        rules.forEach{
            if(it.pair == pair){
                return it.insert
            }
        }
        return ""
    }
}

class Rule(pair: String, insert: String) {
    var pair = pair
    var insert = insert
}