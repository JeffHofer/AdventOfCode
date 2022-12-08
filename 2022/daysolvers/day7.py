from daysolvers.base import SolverBase
from anytree import Node, RenderTree


class Day7Solver(SolverBase):
    day_number = 7

    def part1(self):
        filesystem = self.__parse_filesystem()
        dict = {}
        self.__find_directory_sizes(filesystem, dict)
        sum = 0
        for i in dict:
            if dict[i] < 100000:
                sum += dict[i]
        return sum

    def part2(self):
        filesystem = self.__parse_filesystem()
        dict = {}
        self.__find_directory_sizes(filesystem, dict)
        needed = 30000000 - (70000000 - dict[str(filesystem)])
        smallest_viable = dict[str(filesystem)]
        for i in dict:
            size = dict[i]
            if size > needed and size < smallest_viable:
                smallest_viable = size
        return smallest_viable

    def __parse_filesystem(self):
        input = self.get_daily_input(True, False)
        input.pop(0)
        root = Node("/")
        cd = root
        for i in input:
            if i.startswith("$"): #Command
                command = i.split()[1]
                if command == "cd":
                    dest = i.split()[2]
                    if dest == "/":
                        cd = root
                    elif dest == "..":
                        cd = cd.parent
                    else:
                        for j in cd.children:
                            if j.name == dest:
                                cd = j
            else: #Anything that isn't a command must be ls output
                file = i.split()
                if file[0] == "dir": #directory
                    Node(file[1], cd)
                else: #file
                    Node(File(int(file[0]), file[1]), cd)
        return root

    def __find_directory_sizes(self, filesystem, dict):
        sum = 0
        for i in filesystem.children:
            if isinstance(i.name, File):
                sum += i.name.size
            else:
                sum += self.__find_directory_sizes(i, dict)
        dict[str(filesystem)] = sum
        return sum


    def __print_tree(self, tree):
        for pre, fill, node in RenderTree(tree):
            print("%s%s" % (pre, node.name))


class File():
    def __init__(self, size, name):
        self.size = size
        self.name = name

    def __str__(self):
        return f"{self.size} {self.name}"
