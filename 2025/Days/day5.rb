require_relative 'day'
class Day5 < Day
  DAY = 5

  def self.solve_part1
    input = get_raw_input(DAY)
    fresh_id_ranges, ingredient_ids = parse_ingredients(input)
    fresh_count = 0
    ingredient_ids.each do |id|
      fresh_id_ranges.each do |range|
        if range.include?(id)
          fresh_count += 1
          break
        end
      end
    end
    fresh_count
  end

  def self.solve_part2
    input = get_raw_input(DAY)
    fresh_id_ranges, _ = parse_ingredients(input)
    to_be_merged = fresh_id_ranges.sort_by { |r| r.begin }
    merged_ranges = []
    while to_be_merged.any?
      range = to_be_merged[0].dup
      if merged_ranges.empty?
        merged_ranges << range
        to_be_merged.delete(range)
      else
        handled = false
        merged_ranges.each do |mrange|
          if range.cover?(mrange)
            merged_ranges.delete(mrange)
            handled = true
            break
          elsif mrange.cover?(range)
            to_be_merged.delete(range)
            handled = true
            break
          elsif ranges_overlap?(range, mrange)
            new_range = [range.begin, mrange.begin].min..[range.end, mrange.end].max
            merged_ranges.delete(mrange)
            to_be_merged << new_range
            to_be_merged.delete(range)
            handled = true
            break
          end
        end
        
        unless handled
          merged_ranges << range
          to_be_merged.delete(range)
        end
      end
    end
    range_total = 0
    merged_ranges.each do |range|
      range_total += range.end - range.begin + 1
    end
    range_total 
  end

  private 

  def self.ranges_overlap?(range_a, range_b)
    range_b.begin <= range_a.end && range_a.begin <= range_b.end 
  end 

  def self.parse_ingredients(input)
    fresh_id_ranges = []
    ingredient_ids = []
    ranges_over = false
    input.split("\n").each do |line|
      if line == ""
        ranges_over = true
        next
      end
      if ranges_over
        ingredient_ids << line.to_i
        next
      else
        fresh_id_ranges << (line.split("-").map(&:to_i)[0]..line.split("-").map(&:to_i)[1])
      end
    end
    return fresh_id_ranges, ingredient_ids
  end
end
