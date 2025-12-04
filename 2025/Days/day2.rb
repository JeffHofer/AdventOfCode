require_relative 'day'
class Day2 < Day
  DAY = 2

  def self.solve_part1
    input = get_raw_input(DAY)
    ranges = input.split(",")
    fake_count = 0
    ranges.each do |range|
      bounds = range.split("-").map(&:to_i)
      (bounds[0]..bounds[1]).each do |num|
        next if num < 10
        stringnum = num.to_s
        first_half = stringnum[0..(stringnum.length/2)-1]
        second_half = stringnum[(stringnum.length/2)..-1]
        if first_half == second_half
          fake_count += num
        end
      end
    end
    fake_count
  end

  def self.solve_part2
    input = get_raw_input(DAY)
    ranges = input.split(",")
    fake_count = 0
    ranges.each do |range|
      bounds = range.split("-").map(&:to_i)
      (bounds[0]..bounds[1]).each do |num|
        fake = false
        next if num < 10
        stringnum = num.to_s
        length = stringnum.length
        factor = 1 # The number of repeating digits to check for
        reps_needed = length / factor # How many repetitions are needed to fill the number

        while factor <= length / 2 && !fake
          if length % factor == 0
            split = stringnum.chars.each_slice(factor).map(&:join)
            if split.uniq.size == 1
              fake = true
            end
          end
          factor += 1
        end
 
        if fake 
          fake_count += num
        end
      end
    end
    fake_count
end

end