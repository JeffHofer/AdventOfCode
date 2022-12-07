from daysolvers.base import SolverBase


class Day6Solver(SolverBase):
    day_number = 6

    def part1(self):
        datastream = self.get_daily_input(False, False)
        return self.__find_first_unique_string(datastream, 4)

    def part2(self):
        datastream = self.get_daily_input(False, False)
        return self.__find_first_unique_string(datastream, 14)

    def __find_first_unique_string(self, datastream, length):
        list_stream = [*datastream]
        for i in range(0, len(list_stream)):
            if i > length-1:
                search = list_stream[i-length:i]
                if len(search) == len(set(search)):
                    return i



