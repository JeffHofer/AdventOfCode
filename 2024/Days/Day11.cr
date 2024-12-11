class Day11
  def self.print_solution
    puts "Day 11:\n - Part 1: #{part_1_solution}\n - Part 2: #{part_2_solution}"
  end

  private def self.part_1_solution
    stones = parse_stones
    evolved_stones = evolve_stones(stones, 25)
    total = 0
    evolved_stones.values.each do |count|
      total += count
    end
    total
  end

  private def self.part_2_solution
    stones = parse_stones
    evolved_stones = evolve_stones(stones, 75)
    total = Int64.new(0)
    evolved_stones.values.each do |count|
      total += count
    end
    total
  end

  private def self.evolve_stones(stones, blinks)
    blink_count = 0
    while blink_count < blinks
      new_stones = {} of Int64 => Int64
      stones.keys.each do |stone|
        if stone == 0
          add_stones(new_stones, 1, stones[stone])
        elsif stone.to_s.size % 2 == 0
          add_stones(new_stones, stone.to_s[0, stone.to_s.size // 2].to_i, stones[stone])
          add_stones(new_stones, stone.to_s[stone.to_s.size // 2, stone.to_s.size // 2].to_i, stones[stone])
        else 
          add_stones(new_stones, Int64.new(2024) * stone, stones[stone])
        end
      end
      stones = new_stones
      blink_count += 1
    end
    stones
  end

  private def self.add_stones(stones, stone, count)
    if stones.has_key?(stone)
      stones[stone] += count
    else 
      stones[stone] = count
    end
  end

  private def self.parse_stones
    stone_count = {} of Int64 => Int64
    File.read("./Inputs/day11_input.txt").split.map { |x| stone_count[x.to_i64] = 1 }
    stone_count
  end
end
