cd(@__DIR__)


input = readlines("./INPUT/day05.txt")

splitInd = findfirst(input .== "")

rules = input[1:(splitInd-1)]
rules = [split(r, "|") for r in rules]
rules = hcat(rules...)
rules = parse.(Int, rules)
rules = rules'

updates = input[(splitInd+1):length(input), :]

solution = []
for update in updates
    update = parse.(Int, split(update, ","))
    ind = [r in update for r in rules[:,1]] .&& [r in update for r in rules[:,2]]
    rulesSubset = rules[ind, :]
    OK = true
    for r in eachrow(rulesSubset)
        x = findfirst(r[1] .== update)
        y = findfirst(r[2] .== update)
        if x > y
            OK = false
            break
        end
    end
    if OK
        append!(solution, update[Int(ceil(length(update)/2))])
    end
end

println("Solution of part 1: ", sum(solution))

# part 2

solution2 = []
for update in updates
    update = parse.(Int, split(update, ","))
    ind = [r in update for r in rules[:,1]] .&& [r in update for r in rules[:,2]]
    rulesSubset = rules[ind, :]
    OK = false
    while !OK
        OK = true
        for r in eachrow(rulesSubset)
            x = findfirst(r[1] .== update)
            y = findfirst(r[2] .== update)
            if x > y
                update[x], update[y] = update[y], update[x]
                OK = false
            end
        end
    end
    append!(solution2, update[Int(ceil(length(update)/2))])
end

println("Solution of part 2: ", sum(solution2) - sum(solution))

