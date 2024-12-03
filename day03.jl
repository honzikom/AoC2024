using CSV
using DataFrames

cd(@__DIR__)

input = readlines("./INPUT/day03.txt")
# part 1
patternMul =  r"mul\([^()]*\)"
patternNum = r"\d+"
result = 0

for ind in 1:length(input)
    x = input[ind]
    matches = eachmatch(patternMul, x)
    muls = [m.match for m in matches]
    for mul in muls
        numbers = eachmatch(patternNum, mul)
        numbers = [m.match for m in numbers]
        numbers = parse.(Int, numbers)
        if length(numbers) == 2
            result += numbers[1] * numbers[2]
        end
    end
end

println("solution of part 1: ", result)

# part 2
patternMul = r"mul\([^()]*\)|do\(\)|don't\(\)"
patternNum = r"\d+"
result = 0
on = true
for ind in 1:length(input)
    x = input[ind]
    matches = eachmatch(patternMul, x)
    matches = [m.match for m in matches]
    for match in matches
        if match == "do()"
            on = true
        elseif match == "don't()"
            on = false
        else
            if on
                numbers = eachmatch(patternNum, match)
                numbers = [m.match for m in numbers]
                numbers = parse.(Int, numbers)
                if length(numbers) == 2
                    result += numbers[1] * numbers[2]
                end
            end
        end
    end
end

println("solution of part 2: ", result)
