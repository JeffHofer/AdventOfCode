package Days

class Day12: Day {
    override val DAY = 12

    var caves: MutableMap<String, ArrayList<String>> = mutableMapOf()
    var routes: ArrayList<ArrayList<String>> = arrayListOf()

    override fun challenge1(): Long {
        readCaves()
        var route = arrayListOf<String>()
        route.add("start")
        routesToEnd(route)
        return routes.size.toLong()
    }

    override fun challenge2(): Long {
        readCaves()
        var route = arrayListOf<String>()
        route.add("start")
        routesToEndWithRevisit(route)
        return routes.size.toLong()
    }

    private fun readCaves(){
        caves = mutableMapOf()
        routes = arrayListOf()
        val fileContent  = FileReader.readResource("input12.txt")
        //add one-way associations
        fileContent.forEach {
            var split = it.split('-')
            if (caves.get(split[0]) == null) {
                caves.put(split[0], arrayListOf(split[1]))
            } else {
                caves[split[0]]?.add(split[1])
            }

            if (caves.get(split[1]) == null) {
                caves.put(split[1], arrayListOf(split[0]))
            } else {
                caves[split[1]]?.add(split[0])
            }
        }
    }

    private fun routesToEnd(route: ArrayList<String>) {
        if(route.contains("end")) {
            routes.add(route)
            return
        }

        caves[route.last()]?.forEach {
            if(!(isLowerCase(it) && route.contains(it))) {
                var newRoute = ArrayList(route)
                newRoute.add(it)
                routesToEnd(newRoute)
            }
        }
        return
    }

    private fun routesToEndWithRevisit(route: ArrayList<String>) {
        if(route.contains("end")) {
            routes.add(route)
            return
        }

        caves[route.last()]?.forEach {
//            if(!((it == "start" || it == "end") && route.contains(it)) && !(isLowerCase(it) && hasMultipleLowercase(route))) {
            if(!(isLowerCase(it) && hasMultipleLowercase(route) && route.contains(it)) && it != "start") {
                var newRoute = ArrayList(route)
                newRoute.add(it)
                routesToEndWithRevisit(newRoute)
            }
        }
        return
    }

    private fun isLowerCase(s: String): Boolean {
        for (i in 0 until s.length) {
            if (Character.isUpperCase(s[i])) {
                return false
            }
        }
        return true
    }

    private fun hasMultipleLowercase(route: ArrayList<String>): Boolean {
        var grouped = route.groupingBy { it }.eachCount().filter { it.value > 1 }
        grouped.forEach{
            if(isLowerCase(it.key))
                return true
        }
        return false
    }
}