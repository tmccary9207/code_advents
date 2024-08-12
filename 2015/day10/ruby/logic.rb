def look_and_say(input)
    current = input[0]
    current_count = 0
    output = ""

    input.each_char do |char|
        if current == char
            current_count += 1
        else
            output += current_count.to_s + current
            current = char
            current_count = 1
        end
    end

    output += current_count.to_s + current

    output
end