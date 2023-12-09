##
# Calculate the surface area of the present.
def surface_area(sides)
  sides.map { |x| x * 2 }.sum
end

##
# Calculate the surface area plus slack for a present.
def surface_area_with_slack(input)
  length, width, height = input.split("x").map(&:to_i)
  sides = [(length * width), (width * height), (height * length)]
  surface_area(sides) + sides.min
end
