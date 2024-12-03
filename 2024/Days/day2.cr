class Day2
  def self.print_solution
    puts "Day 2:\n - Part 1: #{part_1_solution}\n - Part 2: #{part_2_solution}"
  end


  private def self.part_1_solution
    reports = get_reports
    total_safe = 0
    reports.each do |report|
      if check_safe(report, false)
        total_safe += 1
      end
    end
    return total_safe
  end

  private def self.part_2_solution
    reports = get_reports
    total_safe = 0
    reports.each do |report|
      if check_safe(report, true)
        total_safe += 1
      end
    end
    return total_safe
  end

  private def self.get_reports
    reports = [] of Array(Int32)
    File.each_line("./Inputs/day2_input.txt") do |line|
      report = line.split.map do |x|
        x.to_i
      end
      reports << report
    end
    reports
  end

  # Checks that the difference between each level is in safe(1-3) range
  # and that the difference between levels always moves in the same direction
  private def self.check_safe(report : Array(Int32), dampener : Bool)
    bad_levels = 0

    prior = nil
    last_diff = nil
    report.each do |level|
      if !prior.nil?
        diff = level - prior
        last_diff = diff if last_diff.nil?
        unless diff.abs >= 1 && diff.abs <= 3 && ((diff < 0) == (last_diff < 0))
          bad_levels +=1
        end
        last_diff = diff
      end
      prior = level
    end
    if dampener
      bad_levels <= 1
    else
      bad_levels == 0
    end
  end
end
