class Day5
  def self.print_solution
    puts "Day 5:\n - Part 1: #{part_1_solution}\n - Part 2: #{part_2_solution}"
  end

  private def self.part_1_solution
    rules, updates = parse_rules_and_updates

    middle_number_total = 0
    updates.each do |update|
      valid, _, _ = check_valid(rules, update)
      middle_number_total += update[update.size // 2] if valid
    end
    middle_number_total
  end

  private def self.part_2_solution
    rules, updates = parse_rules_and_updates

    middle_number_total = 0
    updates.each do |update| 
      valid, _, _ = check_valid(rules, update) 
      unless valid
        fixed = fix_update(rules, update)
        middle_number_total += fixed[fixed.size // 2]
      end
    end
    middle_number_total
  end

  private def self.parse_rules_and_updates
    rules = [] of Array(Int32)
    updates = [] of Array(Int32)
    parsing_rules = true
    File.each_line("./Inputs/day5_input.txt") do |row|
      if row.size == 0
        parsing_rules = false
        next
      end
      if parsing_rules
        rules << row.split('|').map do |x|
          x.to_i
        end
      else 
        updates << row.split(',').map do |x|
          x.to_i
        end
      end
    end
    return rules, updates
  end

  private def self.check_valid(rules, update)
    valid = true
    rules.each do |rule|
      if prereq_page_index = update.index(rule[0])
        if dependent_page_index = update.index(rule[1])
          unless prereq_page_index < dependent_page_index
            return false, prereq_page_index, dependent_page_index
          end
        end
      end
    end
    return true, -1, -1
  end

  private def self.fix_update(rules, update)
    valid, x, y = check_valid(rules, update)
    return update if valid

    hold = update[x]
    update[x] = update[y]
    update[y] = hold
    return fix_update(rules, update)
  end
end
