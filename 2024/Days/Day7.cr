class Day7
  def self.print_solution
    puts "Day 7:\n - Part 1: #{part_1_solution}\n - Part 2: #{part_2_solution}"
  end

  private def self.part_1_solution
    equations = parse_equations
    evaluate_equations(equations, false)
  end

  private def self.part_2_solution
    equations = parse_equations
    evaluate_equations(equations, true)
  end

  private def self.evaluate_equations(equations, include_concat)
    equations = parse_equations
    total = Int64.new(0)
    counter = 1
    equations.each do |equation|
      total += equation[0] if check_equation(equation[1], equation[0], include_concat)
      counter += 1
    end
    total
  end

  private def self.parse_equations
    equations = [] of Tuple(Int64, Array(Int64))
    count = 0
    File.each_line("./Inputs/day7_input.txt") do |line|
      split = line.split(':')
      equations << {split[0].to_i64, split[1].split.map { |x| x.to_i64 }}
    end
    equations
  end

  private def self.check_equation(numbers, target, include_concat)
    if numbers.size == 1
      return numbers[0] == target
    end

    if numbers[0] > target
      return false
    end

    add, mult, concat = operate(numbers)
    
    unless include_concat
      return check_equation(add, target, include_concat) || check_equation(mult, target, include_concat)
    else
      return check_equation(add, target, include_concat) || check_equation(mult, target, include_concat) || check_equation(concat, target, include_concat)
    end
  end

  private def self.operate(numbers)
    add = numbers.clone
    mult = numbers.clone
    concat = numbers.clone

    sum = add[0] + add[1]
    prod = mult[0] * mult[1]
    outcome = (concat[0].to_s + concat[1].to_s).to_i64

    add.shift
    mult.shift
    concat.shift

    add[0] = sum
    mult[0] = prod
    concat[0] = outcome
    return add, mult, concat
  end
end
