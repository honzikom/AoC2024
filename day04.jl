cd(@__DIR__)

input = readlines("./INPUT/day04.csv")
input = [collect(ch) for ch in input]
input = reduce(hcat, input)
input = string.(input)

playground = fill(".", size(input)[1] + 6, size(input)[2] + 6)
playground[3 .+ (1:size(input)[1]), 3 .+ (1:size(input)[2])] .= input

dirs = [[1,0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1], [0, 1], [1, 1]]

xmas = 0
for r in 1:size(playground)[1]
    for s in 1:size(playground)[2]
        if playground[r,s] == "X"
            for dir in dirs
                ind = [r,s]
                word = "X"
                for dummy in 1:3
                    ind .+= dir
                    word *= playground[ind[1], ind[2]]
                end
                if word == "XMAS"
                    xmas += 1
                end
            end
        end
    end
end

println("Solution of part 1: ", xmas)

# part 2

xmas = 0
for r in 1:size(playground)[1]
    for s in 1:size(playground)[2]
        if playground[r,s] == "A"
            if Set([playground[r-1, s-1], playground[r+1, s+1]]) == Set(["M", "S"])
                if Set([playground[r+1, s-1], playground[r-1, s+1]]) == Set(["M", "S"])
                    xmas += 1
                end
            end
        end
    end
end

println("Solution of part 2: ", xmas)
