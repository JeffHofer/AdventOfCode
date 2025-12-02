class Day
  def self.get_raw_input(day)
    File.read(File.join(__dir__, "../Inputs/day#{day}_input.txt")).strip
  end
end