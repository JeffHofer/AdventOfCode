require_relative 'day'
class Day3 < Day
  DAY = 3

  def self.solve_part1
    input = get_raw_input(DAY)
    banks = input.split("\n").map { |line| line.split("").map(&:to_i) }
    return get_total_joltage(banks, 2)
  end

  def self.solve_part2
    input = get_raw_input(DAY)
    banks = input.split("\n").map { |line| line.split("").map(&:to_i) }
    return get_total_joltage(banks, 12)
  end

  private

  def self.get_total_joltage(banks, num_batts)
    total_joltage = 0
    banks.each do |bank|
      batteries_to_find = num_batts
      batteries = []
      search_batteries = bank
      while batteries_to_find > 0
        highest_battery = 9
        while highest_battery >= 0
          highest_battery_index = search_batteries.index(highest_battery)
          if highest_battery_index.nil? || search_batteries.length - highest_battery_index < batteries_to_find
            highest_battery -= 1
            next
          end
          batteries << highest_battery
          batteries_to_find -= 1
          search_batteries = search_batteries[(highest_battery_index + 1)..-1]
          break
        end
      end
      total_joltage += batteries.join.to_i
    end
    total_joltage
  end
end
