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

def look_and_say_2(pairs)
    output = []

    carry = pairs[0][0]
    count = 0
    pairs.each do |pair|
        left = pair[0]
        right = pair[1]
        if carry == left
            if right == left
                count += 2
            else
                output.append([count + 1, carry])
                carry = right
                count = 1
            end
        else
            output.append([count, carry])
            if right == left
                carry = right
                count = 2
            else
                output.append([1, left])
                carry = right
                count = 1
            end
        end
    end
    output.append([count, carry])

    output
end