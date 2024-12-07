class Day6
  def self.print_solution
    map = parse_map
    start_loc, direction = find_start_location(map)
    visited = {} of Array(Int32) => Array(Char)
    visited, loop_spots = traverse(map, start_loc, direction, visited, true)
    
    puts "Day 6:\n - Part 1: #{visited.size}\n - Part 2: #{loop_spots.uniq.size}"
  end

  private def self.parse_map
    rows = [] of Array(Char)
    File.each_line("./Inputs/day6_input.txt") do |row|
      rows << row.chars
    end
    return rows
  end

  private def self.find_start_location(map)
    y = 0
    x = 0
    map.each_with_index do |_, y|
      map[y].each_with_index do |_, x|
        if !['^', 'v', '>', '<'].index(map[y][x]).nil?
          return [x, y], map[y][x]
        end
      end
    end
    raise("No starting point found")
  end

  private def self.direction_map
    { 
      '^' => [0, -1],
      '>' => [1, 0],
      '<' => [-1, 0],
      'v' => [0, 1]
    }
  end

  private def self.mod_for_direction(symbol)
    if step = direction_map[symbol]
      return step
    else
      raise("No direction found for symbol")
    end
  end

  private def self.traverse(map, start_loc, start_direction, visited, top_level)
    loop_spots = [] of Array(Int32)
    x = start_loc[0]
    y = start_loc[1]
    loop_found = false
    direction = start_direction
    while in_bounds(map, [x, y])
      move = true
      next_direction = direction
      coords_in_front = [x + mod_for_direction(direction)[0], y + mod_for_direction(direction)[1]]
      if in_bounds(map, coords_in_front)
        in_front = map[coords_in_front[1]][coords_in_front[0]]

        if in_front == '#'
          next_direction = turn_right(next_direction)
          move = false
        else 
          if top_level
            if !visited.has_key?(coords_in_front)
              map_mod = map.clone
              map_mod[coords_in_front[1]][coords_in_front[0]] = '#'
              _, _, hit = traverse(map_mod, [x, y], direction, visited.clone, false)
              if hit
                loop_spots << coords_in_front
              end
            end
          end
        end
      end

      if visited.has_key?([x, y]) && !visited[[x,y]].index(direction).nil? && in_front != '#'
          loop_found = true
          break
        end

      if visited.has_key?([x,y])
        visited[[x,y]] << direction
      else 
        visited[[x,y]] = [direction]
      end

      direction = next_direction
      if move
        x = x + mod_for_direction(direction)[0]
        y = y + mod_for_direction(direction)[1]
      end
    end
    return visited, loop_spots, loop_found
  end

  private def self.turn_right(direction)
    case direction
    when '^'
      '>'
    when  '>'
      'v'
    when '<'
      '^'
    else
      '<'
    end
  end

  private def self.in_bounds(map, coords)
    return coords[1] < map.size && coords[1] >= 0 && coords[0] < map[coords[1]].size && coords[0] >= 0
  end
end
