require_relative 'day'
class Day4 < Day
  DAY = 4

  def self.solve_part1
    input = get_raw_input(DAY)
    positions = input.split("\n").map { |row| row.split("") }
    accessible_rolls = 0
    positions.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        if positions[y][x] == "@"
          neighboring_rolls = 0
          [x-1, x, x+1].each do |nx|
            [y-1, y, y+1].each do |ny|
              next if nx == x && ny == y
              if ny >= 0 && ny < positions.length && nx >= 0 && nx < positions[ny].length
                neighboring_rolls += 1 if positions[ny][nx] == "@"
              end
            end
          end
          if neighboring_rolls < 4
            accessible_rolls += 1
          end
        end
      end
    end
    accessible_rolls
  end

  def self.solve_part2
    input = get_raw_input(DAY)
    positions = input.split("\n").map { |row| row.split("") }
    removed = 0
    none_left = false
    still_removing = true
    while still_removing
      removing = []
      positions.each_with_index do |row, y|
        row.each_with_index do |cell, x|
          if positions[y][x] == "@"
            neighboring_rolls = 0
            [x-1, x, x+1].each do |nx|
              [y-1, y, y+1].each do |ny|
                next if nx == x && ny == y
                if ny >= 0 && ny < positions.length && nx >= 0 && nx < positions[ny].length
                  neighboring_rolls += 1 if positions[ny][nx] == "@"
                end
              end
            end
            if neighboring_rolls < 4
              removing << [x, y]
            end
          end
        end
      end
      if removing.empty?
        still_removing = false
      else
        removing.each do |x, y|
          positions[y][x] = "."
          removed += 1
        end
      end
    end
    removed
  end
end
