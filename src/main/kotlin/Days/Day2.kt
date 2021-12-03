package Days

import FileReader

class Day2 {
    fun challenge1(): Int{
        var coordinates = applyInstructions(getInstructions())
        return coordinates[0] * coordinates[1]
    }

    fun challenge2(): Int{
        var coordinates = applyInstructionWithAim(getInstructions())
        return coordinates[0] * coordinates[1]
    }
    private fun getInstructions(): List<String>{
        var fileReader = FileReader()
        return fileReader.readResource("input2.txt")
    }

    private fun applyInstructions(instructions: List<String>): Array<Int>{
        var coords = arrayOf(0, 0)
        instructions.forEach {
            var direction: String = it.split(" ")[0]
            var distance: Int = Integer.parseInt(it.split(" ")[1])
            var axis: Int

            if(direction.equals("forward")) {
                axis = 0 //x axis
            } else {
                axis = 1 //y axis
            }

            //Up becomes a negative direction in coordinates
            if(direction.equals("up")) {
                distance = -1 * Math.abs(distance)
            }
            coords[axis] += distance
        }
        return coords;
    }

    private fun applyInstructionWithAim(instructions: List<String>): Array<Int>{
        var coords = arrayOf(0, 0)
        var aim = 0
        instructions.forEach {
            var direction: String = it.split(" ")[0]
            var coefficient: Int = Integer.parseInt(it.split(" ")[1])

            if(direction.equals("up")) {
                aim -= coefficient
            } else if(direction.equals("down")) {
                aim += coefficient
            } else {
                coords[0] += coefficient
                coords[1] += (coefficient * aim)
            }
        }
        return coords;
    }
}