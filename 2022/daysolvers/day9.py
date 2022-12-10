from daysolvers.base import SolverBase


class Day9Solver(SolverBase):
    day_number = 9

    def part1(self):
        moves = [Move(line.split()[0], line.split()[1]) for line in self.get_daily_input(True, False)]
        return self.__count_tail_locations(moves, 2)

    def part2(self):
        moves = [Move(line.split()[0], line.split()[1]) for line in self.get_daily_input(True, False)]
        return self.__count_tail_locations(moves, 10)

    def __count_tail_locations(self, moves, num_knots):
        headpos = [0, 0]
        num_knots = num_knots -1
        knot_positions = []
        for i in range(0, num_knots):
            knot_positions.append(headpos.copy())
        tail_locations = []
        for i in moves:
            for j in i.range():
                headpos[i.axis] += i.range().step #Move head
                prior = headpos
                for k in range(0, num_knots):
                    # Check if the tail needs to move
                    xdif = prior[0] - knot_positions[k][0]
                    ydif = prior[1] - knot_positions[k][1]
                    if abs(xdif) == 2:
                        if abs(ydif) == 2:
                            knot_positions[k][1] += int(ydif/abs(ydif))
                        if abs(ydif) == 1:
                            knot_positions[k][1] = prior[1]
                        knot_positions[k][0] += xdif/abs(xdif)
                    elif abs(ydif) == 2:
                        if abs(xdif) == 2:
                            knot_positions[k][0] += int(xdif/abs(xdif))
                        if abs(xdif) == 1:
                            knot_positions[k][0] = prior[0]
                        knot_positions[k][1] += ydif/abs(ydif)

                    if k == num_knots - 1:
                        tail_locations.append(knot_positions[k].copy())
                    prior = knot_positions[k]
        return len([list(x) for x in set(tuple(x) for x in tail_locations)])




class Move():
    def __init__(self, direction, distance):
        if direction == "U" or direction == "D":
            self.axis = 1
        else:
            self.axis = 0

        if direction == "L" or direction == "D":
            self.distance = -int(distance)
        else:
            self.distance = int(distance)

    def range(self):
        if self.distance < 0:
            return range(0, self.distance, -1)
        else:
            return range(0, self.distance)



