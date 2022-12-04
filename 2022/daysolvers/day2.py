from daysolvers.base import SolverBase

class Day2Solver(SolverBase):
    day_number = 2

    decrypt  = {
        'X': 'A',
        'Y': 'B',
        'Z': 'C'
    }
    #Beats, scores
    letterscores = {
        'A': ['C', 1],
        'B': ['A', 2],
        'C': ['B', 3]
    }

    def part1(self):
        rounds = self.__get_rounds()
        decrypted_rounds = [[round[0], self.decrypt[round[1]]] for round in rounds]
        return sum([self.__find_round_score(round) for round in decrypted_rounds])


    def part2(self):
        rounds = self.__get_rounds()
        solved_rounds = [[round[0], self.__indended_move(round)] for round in rounds]
        return sum([self.__find_round_score(round) for round in solved_rounds])

    def __get_rounds(self):
        list = self.get_daily_input(True, False)
        return [pair.split(" ") for pair in list]

    def __find_round_score(self, pair):
        return self.letterscores[pair[1]][1] + self.__get_round_outcome(pair)

    def __get_round_outcome(self, pair):
        if pair[0] == self.letterscores[pair[1]][0]:
            return 6
        elif pair[1] == self.letterscores[pair[0]][0]:
            return 0
        else:
            return 3

    def __indended_move(self, pair):
        if pair[1] == 'X': #Lose
            return self.letterscores[pair[0]][0]
        if pair[1] == 'Z': #Win
            tempdict = self.letterscores.copy()
            tempdict.pop(self.letterscores[pair[0]][0])
            tempdict.pop(pair[0])
            return max(tempdict)
        else:
            return pair[0]















