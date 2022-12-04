from abc import ABC, abstractmethod
from utilities.filereader import read_input_file

class SolverBase(ABC):
    @property
    @abstractmethod
    def day_number(self):
        pass

    @abstractmethod
    def part1(self):
        pass

    @abstractmethod
    def part2(self):
        pass

    def print_solutions(self):
        print(f"Day {self.day_number}")
        print(f"\tSolution for part 1: {self.part1()}")
        print(f"\tSolution for part 2: {self.part2()}")

    def get_daily_input(self, split, test = False):
        fn = self.test_input_file if test else self.input_file
        return read_input_file(fn, split)


    @property
    def input_file(self):
        return f"Day{str(self.day_number)}.txt"

    @property
    def test_input_file(self):
        return f"Day{self.day_number}_Test.txt"
