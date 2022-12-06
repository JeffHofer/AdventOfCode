from daysolvers.base import SolverBase


class Day5Solver(SolverBase):
    day_number = 5

    def part1(self):
        lines = self.get_daily_input(True)
        stacks = self.__parse_stacks(lines)
        instructions = self.__parse_instructions(lines)
        moved_stacks = self.__excecute_instructions(instructions, stacks, False)
        return "".join([i[-1] for i in moved_stacks if len(i) > 0])

    def part2(self):
        lines = self.get_daily_input(True)
        stacks = self.__parse_stacks(lines)
        instructions = self.__parse_instructions(lines)
        moved_stacks = self.__excecute_instructions(instructions, stacks, True)
        return "".join([i[-1] for i in moved_stacks if len(i) > 0])

    def __parse_stacks(self, lines):
        stacks = [[] for i in range(0, 10)]  # increase this number to support more stacks.
        for i in lines:
            if i.startswith(" 1"):
                break
            count = 0
            for j in range(1, len(i), 4):
                if i[j] != " ":
                    stacks[count].insert(0, i[j])
                count += 1
        return stacks

    def __parse_instructions(self, lines):
        instructions = []
        for i in lines:
            if i.startswith("move"):
                split = i.split()
                inst = Instruction(int(split[1]), int(split[3]), int(split[5]))
                instructions.append(inst)
        return instructions

    def __excecute_instructions(self, instructions, stacks, crane_moves_multiple):
        newstacks = stacks.copy()
        for i in instructions:
            moving = newstacks[i.source - 1][-i.quantity:]
            if crane_moves_multiple == False:
                moving.reverse()
            for j in moving:
                newstacks[i.source - 1].pop(-1)
                newstacks[i.destination - 1].append(j)

        return newstacks


class Instruction():
    def __init__(self, quantity, source, destination):
        self.quantity = quantity
        self.source = source
        self.destination = destination

    def to_string(self):
        return f"move {self.quantity} from {self.source} to {self.destination}"
