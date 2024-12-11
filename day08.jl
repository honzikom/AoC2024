cd(@__DIR__)

input = readlines("./INPUT/day08.txt")
input = [collect(ch) for ch in input]
input = reduce(hcat, input)
input = string.(input)
input = permutedims(input)

symbols = unique(input)
symbols = symbols[symbols .!= "."]

# part 1
result = []

for symbol in symbols
    symbolCoord = findall(x -> x == symbol, input)
    while length(symbolCoord) > 1
        x = popfirst!(symbolCoord)
        for y in symbolCoord
            push!(result, y + y-x)
            push!(result, x + x-y)
        end
    end
end

result = filter(coord -> all(c -> c in 1:size(input)[1], Tuple(coord)), result)
unique!(result)
println("Solution of part 1: ", length(result))

# part 2

result = []

for symbol in symbols
    symbolCoord = findall(x -> x == symbol, input)
    while length(symbolCoord) > 1
        x = popfirst!(symbolCoord)
        push!(result, x)
        for y in symbolCoord
            push!(result, y)
            newPoint = y + y-x
            while all(c -> c in 1:size(input)[1], Tuple(newPoint))
                push!(result, newPoint)
                newPoint += y-x
            end
            newPoint = x + x-y
            while all(c -> c in 1:size(input)[1], Tuple(newPoint))
                push!(result, newPoint)
                newPoint += x-y;
            end 
        end
    end
end

unique!(result)
println("Solution of part 2: ", length(result))