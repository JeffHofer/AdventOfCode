require_relative 'day'
class Day8 < Day
  DAY = 8

  def self.solve_part1
    input = get_raw_input(DAY)
    boxes = []
    input.split("\n").each do |line|
      boxes << Position.new(*line.split(",").map(&:to_i))
    end
    sorted_box_distances = build_sorted_box_distances(boxes)
    circuits, _ = connect_boxes(boxes, sorted_box_distances, 1000)
    sorted_circuits = circuits.sort_by! { |circuit| circuit.length }.reverse!
    sorted_circuits[0].length * sorted_circuits[1].length * sorted_circuits[2].length
  end

  def self.solve_part2
    input = get_raw_input(DAY)
    boxes = []
    input.split("\n").each do |line|
      boxes << Position.new(*line.split(",").map(&:to_i))
    end
    sorted_box_distances = build_sorted_box_distances(boxes)
    _, last_pair = connect_boxes(boxes, sorted_box_distances, sorted_box_distances.length, true)
    last_pair.box1.x * last_pair.box2.x
  end

  private 

  def self.build_sorted_box_distances(boxes)
    box_pairs = []
    boxes.each_with_index do |pos1, index|
      boxes[index + 1..-1].each do |pos2|
        box_pairs << BoxPair.new(pos1, pos2, pos1.distance_from(pos2))
      end
    end
    box_pairs.sort_by! { |pair| pair.distance }
  end

  def self.connect_boxes(boxes, sorted_box_distances, count, stop_when_unified=false)
    circuits = boxes.dup.map { |box| [box] }
    last_pair = nil
    (0..(count - 1)).each do |i|
      if circuits.length == 1 && stop_when_unified
        return circuits, last_pair
      end

      last_pair = sorted_box_distances[i]
      if circuits.empty?
        circuits << [sorted_box_distances[i].box1, sorted_box_distances[i].box2]
        next
      end
      indexes = []
      circuits.each_with_index do |circuit, index|
        if circuit.include?(sorted_box_distances[i].box1) || circuit.include?(sorted_box_distances[i].box2)
          indexes << index
        end
      end
      
      if indexes.length == 2
        circuit1 = circuits[indexes[0]]
        circuit2 = circuits[indexes[1]]
        circuits.delete_at(indexes[1])
        circuits.delete_at(indexes[0])
        circuits << (circuit1 + circuit2).uniq
        next
      elsif indexes.length == 1
        circuits[indexes[0]] << sorted_box_distances[i].box1 unless circuits[indexes[0]].include?(sorted_box_distances[i].box1)
        circuits[indexes[0]] << sorted_box_distances[i].box2 unless circuits[indexes[0]].include?(sorted_box_distances[i].box2)
        next
      else
        circuits << [sorted_box_distances[i].box1, sorted_box_distances[i].box2]
        next
      end
    end
    return circuits, nil
  end
end

class BoxPair
  attr_reader :box1, :box2, :distance

  def initialize(box1, box2, distance)
    @box1 = box1
    @box2 = box2
    @distance = distance
  end
  
  def to_s
    "Box 1: (#{box1.x}, #{box1.y}, #{box1.z}), Box 2: (#{box2.x}, #{box2.y}, #{box2.z}), Distance: #{distance}"
  end
end

class Position
  attr_reader :x, :y, :z

  def initialize(x, y, z)
    @x = x
    @y = y
    @z = z
  end

  def distance_from(other)
    Math.sqrt((@x - other.x)**2 + (@y - other.y)**2 + (@z - other.z)**2)
  end

  def to_s
    "(#{x}, #{y}, #{z})"
  end
end