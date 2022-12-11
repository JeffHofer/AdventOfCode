import math

from daysolvers.base import SolverBase
import operator
import math


class Day11Solver(SolverBase):
    day_number = 11

    ops = {
        "+": operator.add,
        "-": operator.sub,
        "*": operator.mul,
        "/": operator.floordiv
    }

    def part1(self):
        input = self.get_daily_input(True, False)
        monkeys = self.__parse_monkeys(input)
        for i in range(0, 20):
            self.__execute_monkey_turns(monkeys)
        return self.__calculate_monkey_business(monkeys)

    def part2(self):
        input = self.get_daily_input(True, False)
        monkeys = self.__parse_monkeys(input)
        for i in range(0, 10000):
            self.__execute_monkey_turns(monkeys, False)
        return self.__calculate_monkey_business(monkeys)

    def __execute_monkey_turns(self, monkeys, relief=True):
        prod_divisors = math.prod([monkey.testdivisor for monkey in monkeys])

        for i in monkeys:
            for j in i.items:
                if i.operation.operand == "old":
                    operand = j
                else:
                    operand = int(i.operation.operand)
                i.inspectioncount += 1
                worry = i.operation.operator(j, operand)  # Inspection modifier
                if relief:
                    worry = worry // 3  # Relief modifier
                else:
                    worry = worry % prod_divisors
                if worry % i.testdivisor == 0:
                    monkeys[i.trueTarget].items.append(worry)
                else:
                    monkeys[i.falseTarget].items.append(worry)
            i.items = []
        return

    def __calculate_monkey_business(self, monkeys):
        sorted_monkeys = monkeys.copy()
        sorted_monkeys.sort(key=lambda x: x.inspectioncount, reverse=True)
        return sorted_monkeys[0].inspectioncount * sorted_monkeys[1].inspectioncount

    def __parse_monkeys(self, input):
        monkeys = []
        current = Monkey()
        for i in input:
            i = i.strip()
            if i == "":
                monkeys.append(current)
                current = Monkey()
            if i.startswith("Monkey"):
                current.index = int(i.split()[1].strip(":"))
            if i.startswith("Starting"):
                current.items = [int(val.strip(",")) for val in i.split()[2:]]
            if i.startswith("Operation"):
                current.operation = Operation(self.ops[i.split()[4]], i.split()[5])
            if i.startswith("Test"):
                current.testdivisor = int(i.split()[3])
            if i.startswith("If true"):
                current.trueTarget = int(i.split()[5])
            if i.startswith("If false"):
                current.falseTarget = int(i.split()[5])
        monkeys.append(current)
        return monkeys

    def __print_monkeys(self, monkeys):
        for i in monkeys:
            print(str(i))


class Monkey:
    index = None
    items = None
    operation = None
    testdivisor = None
    trueTarget = None
    falseTarget = None
    inspectioncount = 0

    def __str__(self):
        return f""" Monkey {self.index}
    Holds: {self.items}
    Operation: {str(self.operation)} 
    Test: divisible by {self.testdivisor}
        If true: throw to monkey {self.trueTarget}
        If false: throw to monkey {self.falseTarget}
    Inspections: {self.inspectioncount}"""


class Operation:
    def __init__(self, operator, operand):
        self.operator = operator
        self.operand = operand

    def __str__(self):
        return f"new = old {str(self.operator)} {self.operand}"
