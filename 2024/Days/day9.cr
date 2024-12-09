class Day9
  def self.print_solution
    puts "Day 9:\n - Part 1: #{part_1_solution}\n - Part 2: #{part_2_solution}"
  end

  private def self.part_1_solution
    dense_filesystem = parse_dense_filesystem
    expanded_filesystem = expand_filesystem(dense_filesystem)
    compacted_filesystem = compact_expanded_filesystem(expanded_filesystem)
    calculate_checksum(compacted_filesystem)
  end

  private def self.part_2_solution
  dense_filesystem = parse_dense_filesystem
    expanded_filesystem = expand_filesystem(dense_filesystem)
    compacted_filesystem = compact_expanded_filesystem_express(expanded_filesystem)
    calculate_checksum(compacted_filesystem)
  end

  private def self.parse_dense_filesystem
    File.read("./Inputs/day9_input.txt")
  end

  private def self.expand_filesystem(dense_filesystem)
    chars = dense_filesystem.chars
    id = 0
    expanded = [] of String
    chars.each_with_index do |char, x|
      if (x + 2) % 2 == 0
        filesize = char.to_i
        while filesize > 0
          expanded << id.to_s
          filesize -= 1
        end
        id += 1
      else
        filesize = char.to_i
        while filesize > 0
          expanded << "."
          filesize -= 1
        end
      end
    end
    expanded
  end

  private def self.compact_expanded_filesystem(expanded_filesystem)
    front_index = 0
    back_index = expanded_filesystem.size - 1
    while front_index < expanded_filesystem.size - 1
      if expanded_filesystem[front_index] == "."
        while back_index > front_index
          if expanded_filesystem[back_index] != "."
            expanded_filesystem[front_index] = expanded_filesystem[back_index]
            expanded_filesystem[back_index] = "."
            break
          end
          
          back_index -= 1
        end    
      end
      front_index += 1
    end
    expanded_filesystem
  end

  private def self.compact_expanded_filesystem_express(expanded_filesystem)
    back_index = expanded_filesystem.size - 1
    current_id = expanded_filesystem[back_index]
    current_id_size = 0
    moved = [] of String
    while back_index > -1
      if expanded_filesystem[back_index] != current_id
        if current_id != "." && moved.index(current_id).nil?
          moved << current_id
          front_index = 0
          current_gap_size = 0
          while front_index <= back_index
            if expanded_filesystem[front_index] == "."
              current_gap_size += 1
            else 
              current_gap_size = 0
            end
            if current_gap_size == current_id_size
              swap_pos = 0
              while swap_pos < current_id_size
                expanded_filesystem[front_index + 1 - current_id_size + swap_pos] = expanded_filesystem[back_index + 1 + swap_pos]
                expanded_filesystem[back_index + 1 + swap_pos] = "."
                swap_pos +=1
              end
              break
            end
            front_index += 1
          end
        end
        current_id = expanded_filesystem[back_index]
        current_id_size = 0
      end
      current_id_size += 1
      back_index -= 1
    end
    expanded_filesystem
  end

  private def self.calculate_checksum(expanded_filesystem)
    total = Int64.new(0)
    expanded_filesystem.each_with_index do |char, pos|
      unless char == "."
        total += (char.to_i * pos)
      end
    end
    total
  end
end
