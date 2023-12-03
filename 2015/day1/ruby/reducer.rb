##
# Takes in an input and tells us where Santa is.
def reducer(input)
  input.chars.inject(0) do |result, x|
    case x
    when "("
      result + 1
    when ")"
      result - 1
    else
      result
    end
  end
end
