class Day8
  def self.print_solution
    puts "Day 8:\n - Part 1: #{part_1_solution}\n - Part 2: #{part_2_solution}"
  end

  private def self.part_1_solution
    frequency_antennae, limit_x, limit_y = parse_coords
    frequency_antinodes = find_antinodes(frequency_antennae, limit_x, limit_y, false)
    unique_antinode_locations = count_unique_antinode_locations(frequency_antinodes)
    unique_antinode_locations
  end

  private def self.part_2_solution
    frequency_antennae, limit_x, limit_y = parse_coords
    frequency_antinodes = find_antinodes(frequency_antennae, limit_x, limit_y, true)
    unique_antinode_locations = count_unique_antinode_locations(frequency_antinodes)
    unique_antinode_locations
  end

  private def self.parse_coords
    frequency_antennae = {} of Char => Array(Tuple(Int32, Int32))
    y = 0
    width = 0
    File.each_line("./Inputs/day8_input.txt") do |line|
      width = line.size
      line.chars.each_with_index do |char, x|
        if char != '.'
          if frequency_antennae.has_key?(char)
            frequency_antennae[char] << {x, y}
          else
            frequency_antennae[char] = [{x,y}]
          end
        end
      end
      y += 1
    end
    return frequency_antennae, width - 1, y - 1
  end

  private def self.find_antinodes(frequency_antennae, limit_x, limit_y, consider_harmonics)
    frequency_antinodes = {} of Char => Array(Tuple(Int32, Int32))
    frequency_antennae.each do |freq_map|
      freq = freq_map[0]
      antinode_coords = [] of Tuple(Int32, Int32)

      freq_map[1].each do |loc1|
        freq_map[1].each do |loc2|
          unless loc1 == loc2
            distance = {loc2[0] - loc1[0], loc2[1] - loc1[1]}
            
            in_bounds = true
            iteration = consider_harmonics ? 0 : 1
            while(in_bounds)
              antinode_loc = {loc2[0] + (distance[0] * iteration), loc2[1] + (distance[1] * iteration)}
              in_bounds = in_bounds(antinode_loc, limit_x, limit_y)
              antinode_coords << antinode_loc if in_bounds
              in_bounds = false if !consider_harmonics #Perform only one iteration if we're not considering harmonics
              iteration += 1
            end
          end
        end
      end
      frequency_antinodes[freq] = antinode_coords.uniq
    end
    frequency_antinodes
  end

  private def self.in_bounds(coords, limit_x, limit_y)
    coords[0] >= 0 && coords[0] <= limit_x && coords[1] >= 0 && coords[1] <= limit_y
  end

  private def self.count_unique_antinode_locations(frequency_antinodes)
    all_coords = [] of Tuple(Int32, Int32)
    frequency_antinodes.each do |freq_map|
      all_coords = all_coords | freq_map[1]
    end
    all_coords.uniq.size
  end

end
