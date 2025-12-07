require_relative 'day'
class Day6 < Day
  DAY = 6

  def self.solve_part1
    input = get_raw_input(DAY)
    lines = input.split("\n").map(&:split)
    numbers = lines[0..-2].map { |line| line.map(&:to_i) }
    operators = lines[-1]
    equations = []
    (0...operators.length).each do |i|
      equations << Equation.new(numbers.map{|row| row[i]}, operators[i])
    end
    solve_equations(equations)
  end

  def self.solve_part2
    input = get_raw_input(DAY)
    lines = input.split("\n")
    length = lines.max_by(&:length).length

    numberlines = lines[0..-2]
    operators = lines[-1]
    
    equations = []
    numbers = []
    (length - 1).downto(0-1).each do |i|
      if numberlines.map{|line| line[i]}.uniq == [" "] || i == -1
        equations << Equation.new(numbers, operators[i+1])
        numbers = []
        next
      end
      num = ""
      numberlines.each do |line|
        num << line[i] unless line[i].nil? || line[i] == " "
      end
      numbers << num.to_i
    end
    solve_equations(equations)
  end

  private 

  def self.solve_equations(equations)
    grand_total = 0
    equations.each do |equation|
      case equation.operator
      when "+"
        grand_total += equation.numbers.inject(0, :+)
      when "*"
        grand_total += equation.numbers.inject(1, :*)
      else
        raise "Unknown operator #{equation.operator}"
      end
    end
    grand_total
  end
end

class Equation
  attr_reader :numbers, :operator
  def initialize(numbers, operator)
    @numbers = numbers
    @operator = operator
  end
end