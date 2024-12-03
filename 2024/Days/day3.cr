class Day3
  def self.print_solution
    puts "Day 3:\n - Part 1: #{part_1_solution}\n - Part 2: #{part_2_solution}"
  end

  private def self.part_1_solution
    memory = get_memory
    instructions = parse_instructions(memory)
    total = 0
    instructions.each do |instruction|
      if instruction.type == "mul"
        total += instruction.params_list[0] * instruction.params_list[1] 
      end
    end
    total
  end

  private def self.part_2_solution
    memory = get_memory
    instructions = parse_instructions(memory)
    total = 0
    enabled = true
    instructions.each do |instruction|
      if instruction.type == "mul"
        total += instruction.params_list[0] * instruction.params_list[1] if enabled
      elsif instruction.type == "do"
        enabled = true
      elsif instruction.type == "don't"
        enabled = false
      end
    end
    total
  end

  private def self.parse_instructions(memory)
    regex = /(mul)\((\d+)\,(\d+)\)|(don't)\(\)|(do)\(\)/
    instructions = memory.scan(regex).map do |match_data|
      array = match_data.to_a.compact 
      Instruction.new(array[1], array[2, array.size - 2].map{ |x| x.to_i})
    end
    instructions
  end

  private def self.get_memory
    File.read_lines("./Inputs/day3_input.txt").join
  end

  class Instruction
    getter type : String
    getter params_list : Array(Int32)

    def initialize(type : String, params_list : Array(Int32))
      @type = type
      @params_list = params_list
    end
  end

end
