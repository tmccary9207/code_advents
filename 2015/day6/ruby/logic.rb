##
# Translates an instructions line to a hash.
def translate_instructions(instructions)
  result = instructions.match(/(?<action>.*)\s(?<fromPositionStart>\d+)\,(?<fromPositionEnd>\d+).*\s(?<toPositionStart>\d+)\,(?<toPositionEnd>\d+)/)

  if result.nil?
    nil
  else
    result.named_captures
  end
end

##
# Runs all instructions and returns the number of lights that are on.
def run_instructions(all_instructions)
  all_lights = Array.new(1000) { Array.new(1000, 0) }

  all_instructions.split("\n").each do |instruction_string|
    instruction_hash = translate_instructions instruction_string

    if instruction_hash.nil? then
      next
    end

    (instruction_hash["fromPositionStart"].to_i()..instruction_hash["toPositionStart"].to_i()).each do |x|
      (instruction_hash["fromPositionEnd"].to_i()..instruction_hash["toPositionEnd"].to_i()).each do |y|
        if instruction_hash["action"] == "toggle" then
          state = all_lights[x][y]
          all_lights[x][y] = if state == 0 then 1 else 0 end
          next
        end
        if instruction_hash["action"] == "turn off" then
          all_lights[x][y] = 0
          next
        end
        all_lights[x][y] = 1
      end
    end
  end

  light_count = 0

  all_lights.each do |row|
    row.each do |light|
      light_count += light
    end
  end

  light_count
end

##
# Runs all instructions and returns the brightness of the light array.
def run_instructions2(all_instructions)
  all_lights = Array.new(1000) { Array.new(1000, 0) }

  all_instructions.split("\n").each do |instruction_string|
    instruction_hash = translate_instructions instruction_string

    if instruction_hash.nil? then
      next
    end

    (instruction_hash["fromPositionStart"].to_i()..instruction_hash["toPositionStart"].to_i()).each do |x|
      (instruction_hash["fromPositionEnd"].to_i()..instruction_hash["toPositionEnd"].to_i()).each do |y|
        state = all_lights[x][y]
        if instruction_hash["action"] == "toggle" then
          all_lights[x][y] = state + 2
          next
        end
        if instruction_hash["action"] == "turn off" then
          all_lights[x][y] = if state - 1 != -1 then
                               state - 1
                             else
                               0
                             end
          next
        end
        all_lights[x][y] = state + 1
      end
    end
  end

  brightness = 0

  all_lights.each do |row|
    row.each do |light|
      brightness += light
    end
  end

  brightness
end
