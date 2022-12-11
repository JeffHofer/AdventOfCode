from daysolvers.base import SolverBase


class Day10Solver(SolverBase):
    day_number = 10

    def part1(self):
        instructions = self.get_daily_input(True, False)
        return self.__sum_signal_strengths(instructions)

    def part2(self):
        instructions = self.get_daily_input(True, False)
        return self._display_sprites(instructions   )

    def __sum_signal_strengths(self, instructions):
        sum = 0
        cycle = 0
        x = 1
        for i in instructions:
            cycles = 1
            xmod = 0
            if(i.startswith("addx")):
                cycles = 2
                xmod = int(i.split()[1])
            for j in range(cycles):
                cycle += 1
                if (cycle - 20 == 0 or (cycle - 20) % 40 == 0) and cycle < 221:
                    sum += (x * cycle)
            x+= xmod
        return sum

    def _display_sprites(self, instructions):
        pixels = []
        cycle = 0
        x = 1
        for i in instructions:
            cycles = 1
            xmod = 0
            if (i.startswith("addx")):
                cycles = 2
                xmod = int(i.split()[1])
            for j in range(cycles):
                screenpos = cycle % 40
                if abs(screenpos - x) < 2:
                    pixels.append('#')
                else:
                    pixels.append(".")
                cycle += 1
            x+= xmod
        self.__print_screen(pixels)
        return "Above"

    def __print_screen(self, pixels):
        for i in range(0, 240, 40):
            print("".join(pixels[i:i+40]))