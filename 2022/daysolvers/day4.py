from daysolvers.base import SolverBase

class Day4Solver(SolverBase):
    day_number = 4


    def part1(self):
        assignment_pairs = self.__get_assignment_pairs()
        sum = 0
        for i in assignment_pairs:
            if i[0].start in i[1] and i[0][-1] in i[1] or i[1].start in i[0] and i[1][-1] in i[0]:
                sum += 1
        return sum


    def part2(self):
        assignment_pairs = self.__get_assignment_pairs()

        sum = 0
        for i in assignment_pairs:
            if i[0].stop -1 >= i[1].start and i[0].start <= i[1].stop -1:
                sum += 1
        return sum


    def __get_assignment_pairs(self):
        input = self.get_daily_input(True, False)
        return [[range(int(assignment[0].split('-')[0]), int(assignment[0].split('-')[1]) + 1), range(int(assignment[1].split('-')[0]), int(assignment[1].split('-')[1]) + 1)] for assignment in [line.split(',') for line in input]]











