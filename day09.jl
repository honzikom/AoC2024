cd( @__DIR__)

input = readlines("./INPUT/day09.txt")[1]
input = split(input, "")
input = parse.(Int, input)

parsedInput = []
id = 0
while length(input) > 1
    x = popfirst!(input)
    parsedInput = vcat(parsedInput, fill(id, x))
    x = popfirst!(input)
    parsedInput = vcat(parsedInput, fill(missing, x))
    id += 1    
end
x = popfirst!(input)
parsedInput = vcat(parsedInput, fill(id, x))

nMissing = sum(ismissing.(parsedInput))
nonMissing = parsedInput[.! ismissing.(parsedInput)]
filler = reverse!(nonMissing)[1:nMissing]
parsedInput[ismissing.(parsedInput)] .= filler
parsedInput = parsedInput[1:(length(parsedInput)-nMissing)]

sol1 = sum(collect(0:(length(parsedInput)-1)) .* parsedInput)
println("Solution of part 1: ", sol1)

# part 2

input = readlines("./INPUT/day09.txt")[1]
input = split(input, "")
input = parse.(Int, input)

holesStart = 1 .+ cumsum(input)[1:2:end]
holesSize = input[2:2:end]
pop!(holesStart)
numberStart = vcat(1, 1 .+ cumsum(input)[2:2:end])
parsedInput = []
id = 0
while length(input) > 1
    x = popfirst!(input)
    parsedInput = vcat(parsedInput, fill(id, x))
    x = popfirst!(input)
    parsedInput = vcat(parsedInput, fill(missing, x))
    id += 1    
end
x = popfirst!(input)
parsedInput = vcat(parsedInput, fill(id, x))

input = readlines("./INPUT/day09.txt")[1]
input = split(input, "")
input = parse.(Int, input)

println(id)
while id > 0
    space = pop!(input)
    numberInd = pop!(numberStart)
    holeInd = findfirst(x -> x >= space, holesSize[holesStart .< numberInd])
    if !isnothing(holeInd)
        parsedInput[.!ismissing.(parsedInput) .&& parsedInput .== id] .= missing
        parsedInput[holesStart[holeInd]:(holesStart[holeInd] + space - 1)] .= id
        holesStart[holeInd] += space
        holesSize[holeInd] -= space 
    end
    if id > 1
        pop!(input)
    end
    id -= 1
end

parsedInput[ismissing.(parsedInput)] .= 0
sol2 = sum(collect(0:(length(parsedInput)-1)) .* parsedInput)
println("Solution of part 1: ", sol2)