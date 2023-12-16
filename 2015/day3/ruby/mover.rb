##
# Get the new location for Santa.
def new_location(current_location, direction)
  case direction
  when "^"
    [current_location[0], current_location[1] + 1]
  when "v"
    [current_location[0], current_location[1] - 1]
  when ">"
    [current_location[0] + 1, current_location[1]]
  when "<"
    [current_location[0] - 1, current_location[1]]
  else
    current_location
  end
end

##
# Takes in directions from an elf and returns the number of unique houses Santa visited.
def take_directions(directions)
  visited = Set["0,0"]
  current_location = [0, 0]
  directions.each_char do |direction|
    current_location = new_location(current_location, direction)
    visited.add "#{current_location[0]},#{current_location[1]}"
  end
  visited.size
end
