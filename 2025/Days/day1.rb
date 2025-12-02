require_relative 'day'
class Day1 < Day
  DAY = 1

  def self.solve_part1
    input = get_raw_input(DAY)
    turns = input.split("\n").map { |turn| Turn.new(turn) }
    pass_zero = 0
    pos = 50
    turns.each do |turn|
      (1..turn.steps).each do
        if turn.direction == 'L'
          pos -= 1
        elsif turn.direction ==   'R'
          pos += 1
        end
        
        if pos == 100
          pos = 0
        elsif pos == -1
          pos = 99
        end
      end
      if pos == 0
        pass_zero += 1
      end
    end
    pass_zero
  end

  def self.solve_part2
    input = get_raw_input(DAY)
    turns = input.split("\n").map { |turn| Turn.new(turn) }
    pass_zero = 0
    pos = 50
    turns.each do |turn|
      (1..turn.steps).each do
        if turn.direction == 'L'
          pos -= 1
        elsif turn.direction ==   'R'
          pos += 1
        end
        
        if pos == 100
          pos = 0
        elsif pos == -1
          pos = 99
        end

        if pos == 0
          pass_zero += 1
        end
      end
    end
    pass_zero
  end
end

class Turn 
  attr_reader :direction, :steps

  def initialize(instruction)
    @direction = instruction[0]
    @steps = instruction[1..-1].to_i
  end
end