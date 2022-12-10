from daysolvers.base import SolverBase


class Day8Solver(SolverBase):
    day_number = 8

    def part1(self):
        input = self.get_daily_input(True, False)
        return self.__count_visible_trees("".join(input), len(input), len(input[0]))

    def part2(self):
        input = self.get_daily_input(True, False)
        return self.__find_highest_scenic_score("".join(input), len(input), len(input[0]))

    def __count_visible_trees(self, trees, numrows, numcols):
        count = 0
        for i in range(0, len(trees)):
            visibledirections = 4
            row = i // numcols
            col = i - (row * numrows)
            directions = [range(i-col, i),
                          range(i+1, i+(numcols - col)),
                          range(col, i, numcols),
                          range(i+numcols, len(trees), numcols)]
            for j in directions:
                for k in j:
                    if trees[k] >= trees[i]:
                        visibledirections -= 1
                        break
            if visibledirections > 0:
                count += 1
        return count

    def __find_highest_scenic_score(self, trees, numrows, numcols):
        highest = 0
        for i in range(0, len(trees)):
            row = i // numcols
            col = i - (row * numrows)
            directions = [range(i-1, i - col -1, -1),
                          range(i + 1, i + (numcols - col)),
                          range(i - numcols, col -1, -numcols),
                          range(i + numcols, len(trees), numcols)]
            score = 1
            for j in directions:
                visibility = 0
                for k in j:
                    visibility +=1
                    if int(trees[k]) >= int(trees[i]):
                        break
                score = score * visibility

            if score > highest:
                highest = score
        return highest