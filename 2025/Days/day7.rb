require_relative 'day'
class Day7 < Day
  DAY = 7

  def self.solve_part1
    input = get_raw_input(DAY)
    lines = input.split("\n")
    first = lines.first.index("S")
    beams = [first]
    splits = 0
    lines.each do |line|
      new_beams = []
      beams.each do |beam|
        if line[beam] == "^"
          new_beams << beam - 1
          new_beams << beam + 1
          splits += 1
        else
          new_beams << beam
        end
      end
      beams = new_beams.uniq
    end
    splits
  end

  def self.solve_part2
    input = get_raw_input(DAY)
    lines = input.split("\n")
    first = lines.first.index("S")
    realities = { first => 1 }
    lines.each do |line|
      realities.keys.each do |beam|
        if line[beam] == "^"
          if realities[beam+1].nil?
            realities[beam+1] = realities[beam]
          else
            realities[beam+1] += realities[beam]
          end

          if realities[beam-1].nil?
            realities[beam-1] = realities[beam]
          else
            realities[beam-1] += realities[beam]
          end
          realities.delete(beam)
        end
      end
    end
    realities.values.sum
  end
end