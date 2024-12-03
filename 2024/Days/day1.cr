class Day1
  def self.print_solution
    puts "Day 1:\n - Part 1: #{part_1_solution}\n - Part 2: #{part_2_solution}"
  end

  private def self.part_1_solution
    list1, list2 = get_input_lists
    list1 = list1.sort!
    list2 = list2.sort!

    total_deviation = 0
    i = 0
    while i < list1.size
      deviation = (list1[i] - list2[i]).abs
      total_deviation += deviation
      i += 1
    end
    
    total_deviation
  end

  private def self.part_2_solution
    list1, list2 = get_input_lists

    list2_hash = {} of Int32 => Int32
    i = 0
    while i < list2.size
      if list2_hash[list2[i]]? == nil
        list2_hash[list2[i]] = 1
      else
        list2_hash[list2[i]] += 1
      end
      i += 1
    end

    total_similarity_score = 0
    i = 0
    while i < list1.size
      similarity_score = list1[i] * (list2_hash[list1[i]]? || 0)
      total_similarity_score += similarity_score
      i += 1
    end
    total_similarity_score
  end

  private def self.get_input_lists
    list1 = [] of Int32
    list2 = [] of Int32
    File.each_line("./Inputs/day1_input.txt") do |line|
      nums = line.split
      list1 << nums[0].to_i
      list2<< nums[1].to_i
    end
    return list1, list2
  end
end
