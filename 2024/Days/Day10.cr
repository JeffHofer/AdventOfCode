class Day10
  def self.print_solution
    puts "Day 10:\n - Part 1: #{part_1_solution}\n - Part 2: #{part_2_solution}"
  end

  private def self.part_1_solution
    map = parse_map
    total = 0
    map.each_with_index do |row, y|
      row.each_with_index do |col, x|
        if map[y][x] == 0
          connected = [] of Array(Int32)
          count_trails(map, x, y, 0, connected)
          total += connected.uniq.size
        end
      end
    end
    total
  end

  private def self.part_2_solution
    map = parse_map
    total = 0
    map.each_with_index do |row, y|
      row.each_with_index do |col, x|
        if map[y][x] == 0
          connected = [] of Array(Int32)
          count_trails(map, x, y, 0, connected)
          total += connected.size
        end
      end
    end
    total
  end

  private def self.parse_map
    map = [] of Array(Int32)
    File.each_line("./Inputs/day10_input.txt") do |row|
      map << row.chars.map { |x| x.to_i }
    end
    map
  end

  private def self.count_trails(map, x, y, next_elevation, connected)
    if !in_bounds(map, x, y) || map[y][x] != next_elevation
      return
    elsif map[y][x] == 9 && next_elevation == 9
      connected << [x, y]
      return
    else
      search = next_elevation + 1
      count_trails(map, x + 1, y, search, connected)
      count_trails(map, x, y + 1, search, connected)
      count_trails(map, x - 1, y, search, connected)
      count_trails(map, x, y - 1, search, connected)
    end
  end

  private def self.in_bounds(map, x, y)
    y >= 0 && y < map.size && x >= 0 && x < map[y].size
  end
end
