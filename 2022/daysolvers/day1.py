from daysolvers.base import SolverBase
from utilities.arraytools import parse_to_int_array
from utilities.arraytools import split_segmented_list
from utilities.arraytools import find_largest_elements


class Day1Solver(SolverBase):
    day_number = 1

    def part1(self):
        sums = self.__get_summed_input_array()
        return max(sums)

    def part2(self):
        sums = self.__get_summed_input_array()
        return sum(find_largest_elements(sums, 3))

    def __get_summed_input_array(self):
        list = self.get_daily_input(True)
        return [sum(parse_to_int_array(bundle)) for bundle in split_segmented_list(list, '')]










