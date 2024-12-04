class Day4
  def self.print_solution
    puts "Day 4:\n - Part 1: #{part_1_solution}\n - Part 2: #{part_2_solution}"
  end

  private def self.part_1_solution
    word_search = get_word_search
    total = count_word(word_search, ['X', 'M', 'A', 'S'])
  end

  private def self.part_2_solution
    word_search = get_word_search
    total = count_xmas(word_search)
  end

  private def self.get_word_search
    word_search = [] of Array(Char)
    File.each_line("./Inputs/day4_input.txt") do |row|
      word_search << row.chars
    end
    word_search
  end

  private def self.count_word(word_search, letters : Array(Char))
    count = 0
    row = 0
    col = 0
    while row < word_search.size
      while col < word_search[row].size
        count += search_for_substring(word_search, letters, row, col, nil)
        col += 1
      end
      col = 0
      row += 1
    end
    count
  end

  private def self.search_for_substring(word_search, letters : Array(Char), current_row, current_col, step : Array(Int32)?)
    # If we're traveling out of bounds, it's not a match
    return 0 if word_search.size <= current_row || current_row < 0 || word_search[current_row].size <= current_col || current_col < 0
    # If the current letter isn't correct, it's not a match
    return 0 if word_search[current_row][current_col] != letters[0]
    # If the current letter is the last letter in the word, it's not a match
    if letters.size == 1 && letters[0] == word_search[current_row][current_col]
      return 1
    end

    if step.nil? # There is no direction yet so we check all directions
      total = 0
      [-1, 0, 1].each do |row_mod|
        [-1, 0, 1].each do |col_mod|
          total += search_for_substring(word_search, letters.last(letters.size - 1), current_row + row_mod, current_col + col_mod, [row_mod, col_mod])
        end
      end
      return total
    else  
      return search_for_substring(word_search, letters.last(letters.size - 1), current_row + step[0], current_col + step[1], step)
    end
  end

  private def self.count_xmas(word_search)
    count = 0
    row = 0
    col = 0
    while row < word_search.size
      while col < word_search[row].size
        count += 1 if check_if_center_of_x(word_search, row, col)
        col += 1
      end
      col = 0
      row += 1
    end
    count
  end

  private def self.check_if_center_of_x(word_search, row, col)
    # center of an x can't be on an edge
    return false if row == 0 || row == word_search.size - 1 || col == 0 || col == word_search[row].size - 1
    # Only "A" can be the center of an X
    return false if word_search[row][col] != 'A'

    corners = [word_search[row - 1][col - 1], word_search[row - 1][col + 1], word_search[row + 1][col - 1], word_search[row + 1][col + 1]]

    # Opposing corners can't be the same 
    return false if corners[0] == corners[3] || corners[1] == corners[2]

    # If there's 2 M's and 2 X's on non-opposing corners, we're at the center of an X
    s_count = 0
    m_count = 0
    corners.each do |char|
      s_count += 1 if char == 'S'
      m_count += 1 if char == 'M'
    end

    s_count == 2 && m_count == 2
  end
end
