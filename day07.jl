cd(@__DIR__)

input = readlines("./INPUT/day07.txt")
result = 0

for x in input
    
    x = parse.(Int, split(x, r" |: "))
    target = popfirst!(x)
    curValues = [popfirst!(x)]
    
    while length(x) > 0
        numberToAM = popfirst!(x)
        newValues = []
        while length(curValues) > 0
            v = popfirst!(curValues)
            push!(newValues, v + numberToAM)
            push!(newValues, v * numberToAM)
            # next line is difference between part 1 and part 2, comment for part 1
            push!(newValues, parse(Int, string(v) * string(numberToAM)))
        end
        curValues = newValues
    end

    if any(target .∈ curValues)
        result += target
    end

end

println("Solution is: ", result)