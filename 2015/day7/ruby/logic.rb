# frozen_string_literal: true

ASSIGN_PATTERN = /^(?<wire_value>\d+)$/.freeze
SOURCE_PATTERN = /^(?<source>\w+)$/.freeze
NOT_PATTERN = /^(?<logic_operator>\w+)\s(?<logic_right>\w+)$/.freeze
LOGIC_PATTERN = /^(?<logic_left>\w+)\s(?<logic_operator>\w+)\s(?<logic_right>\w+|\d+)$/.freeze
PATTERNS = [ASSIGN_PATTERN, SOURCE_PATTERN, NOT_PATTERN, LOGIC_PATTERN].freeze

# Translates instructions into a label, instruction array.
def translate_instructions(input)
  logic, label = input.split(' -> ')
  return nil if label.nil?

  matches = PATTERNS.inject(nil) { |found, pattern| found || logic.match(pattern) }
  caps = matches.named_captures
  caps.transform_values! { |v| v.match(/^\d+$/) ? v.to_i : v }
  [label, caps]
end

# Translates instructions into a wire hash.
def instructions_to_wire_hash(input)
  wires = {}
  input.split("\n").each do |line|
    label, instructions = translate_instructions(line)
    next if label.nil?

    wires[label] = (instructions['wire_value'] || instructions)
  end
  wires
end

# Checks if instruction can be performed.
def can_instruction_be_performed?(instruction, wires) # rubocop:disable Metrics/AbcSize
  if instruction['source']
    # SOURCE
    return wires[instruction['source']].is_a?(Numeric)
  elsif instruction['logic_left']
    # LEFT LOGIC CHECK
    return false if !instruction['logic_left'].is_a?(Numeric) && !wires[instruction['logic_left']].is_a?(Numeric)
  end

  # RIGHT LOGIC CHECK
  instruction['logic_right'].is_a?(Numeric) || wires[instruction['logic_right']].is_a?(Numeric)
end

# Performs the instruction and returns the value calculated.
def perform_instruction(instruction, wires) # rubocop:disable Metrics/MethodLength
  left = instruction['logic_left']
  left = left.is_a?(Numeric) ? left : wires[left]
  right = instruction['logic_right']
  right = right.is_a?(Numeric) ? right : wires[right]
  case instruction['logic_operator']
  when 'NOT'
    (~right & 0xFFFF)
  when 'AND'
    (left & right)
  when 'OR'
    (left | right)
  when 'LSHIFT'
    (left << right) & 0xFFFF
  else
    (left >> right) & 0xFFFF
  end
end

# Iterates over the wires and returns a flag indicating if work was done.
def walk_wires(wires) # rubocop:disable Metrics/MethodLength
  performed_work = false
  wires.each do |wire_label, value_or_instruction|
    next if value_or_instruction.is_a?(Numeric)
    next unless can_instruction_be_performed?(value_or_instruction, wires)

    wires[wire_label] = if value_or_instruction['source']
                          wires[value_or_instruction['source']]
                        else
                          perform_instruction(value_or_instruction, wires)
                        end
    performed_work = true
  end
  performed_work
end

# Runs in the instructions and returns value of target_wire.
def run_instructions(text, target_wire = 'a', override = nil)
  wires = instructions_to_wire_hash(text)
  wires[override['wire']] = override['value'] unless override.nil?

  while walk_wires(wires) && !wires[target_wire].is_a?(Numeric)
  end

  wires[target_wire] || 0
end
