from daysolvers.base import SolverBase

class Day3Solver(SolverBase):
    day_number = 3


    def part1(self):
        list = self.get_daily_input(True, False)
        return sum([self.__find_duplicate_item_score(rucksack) for rucksack in list])


    def part2(self):
        rucksacks = self.get_daily_input(True, False)
        sum = 0
        group = []
        for i in range(0, len(rucksacks)):
            group.append(list(rucksacks[i]))
            if ((i + 1) % 3) == 0:
                #find intersection
                common = [value for value in group[0] if value in [value for value in group[2] if value in group[1]]]
                sum += self.__find_item_value(common[0])
                group = []
        return sum

    def __find_duplicate_item_score(self, contents):
        compsize = int(len(contents) / 2)
        com1 = contents[:compsize]
        com2 = contents[compsize:]
        return self.__find_item_value([value for value in com1 if value in com2][0])

    def __find_item_value(self, item):
        if item.isupper():
            return ord(item) - 38
        else:
            return ord(item) - 96












