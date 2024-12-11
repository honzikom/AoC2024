cd( @__DIR__)

using Serialization
using SparseArrays

input = readlines("./INPUT/day11.txt")[1]
input = parse.(Int, split(input, " "))


function blink(x)
    if x == 0
        return Int(1)
    else
        nDigits = 1 + Int(floor(log10(x)))
        if nDigits % 2 == 0
            return [Int(x ÷ (10 ^ (nDigits/2))), Int(x % (10^(nDigits/2)))]
        else
            return Int(x * 2024)
        end
    end
end


# x = input
# while true
#     xx = vcat(blink.(x)...)
#     xx = vcat(xx, x)
#     xx = unique(Int64.(xx))
#     if length(xx) == length(x)
#         break
#     end
#     x = xx
# end
# x = sort(x)

# # store for future use
# serialize("allValues.jls", x)

possibleValues = deserialize("allValues.jls")

blinkMatrix = zeros(Int, length(possibleValues), length(possibleValues))
for i in 1:length(possibleValues)
    y = vcat(blink(possibleValues[i])...)
    for yy in y
        j = findfirst(x -> x==yy, possibleValues)
        blinkMatrix[i, j] += 1
    end
end

startingVec = fill(0, length(possibleValues))
startingVec[findall(x -> x in input, possibleValues)] .= 1

blinkMatrix = sparse(blinkMatrix)
B25 = blinkMatrix^75
print("Solution of part 1 is:", sum(startingVec' * B25))

B75 = blinkMatrix^75
print("Solution of part 2 is:", sum(startingVec' * B75))