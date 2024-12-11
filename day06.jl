using CSV
using DataFrames

cd(@__DIR__)

input = readlines("./INPUT/day06.txt")
input = [collect(ch) for ch in input]
input = reduce(hcat, input)
input = string.(input)
input = permutedims(input)

playground = fill("O", size(input)[1] + 2, size(input)[2] + 2)
playground[1 .+ (1:size(input)[1]), 1 .+ (1:size(input)[2])] .= input

#star 1
pos =  findall(x -> x == "^", playground)
pos = vec(hcat([collect(Tuple(p)) for p in pos]...))
dir = [-1, 0]
path = []
while pos[1] != 1 && pos[1] != size(playground)[1] && pos[2] != 1 && pos[2] != size(playground)[2]
    playground[pos[1], pos[2]] = "X"
    # check if next value is #
    nextPos = pos .+ dir
    if playground[nextPos[1], nextPos[2]] == "#"
        dir[1], dir[2] = dir[2], -dir[1]
    else
        push!(path, (copy(pos), copy(dir)))
        pos = nextPos
    end
end
CSV.write("star1.csv", DataFrame(playground, :auto))

println("Solution of part 1: ",count(x -> x == "X", playground))
Set(path)
#star 2
cycles = []
playground = fill("O", size(input)[1] + 2, size(input)[2] + 2)
playground[1 .+ (1:size(input)[1]), 1 .+ (1:size(input)[2])] .= input

for i in 2:(length(path)-1)
    println(i, "/", length(path))
    curPath = copy(path[1:i])
    obstacle = copy(playground)
    lastPos = pop!(curPath)
    pos = copy(lastPos[1])
    dir = copy(lastPos[2])
    nextPos = pos .+ dir
    obPos = copy(nextPos)
    if obstacle[nextPos[1], nextPos[2]] != "#" && ! any(t -> t[1] == nextPos, curPath)
        obstacle[nextPos[1], nextPos[2]] = "#"
        while pos[1] != 1 && pos[1] != size(playground)[1] && pos[2] != 1 && pos[2] != size(playground)[2]
            nextPos = pos .+ dir
            if obstacle[nextPos[1], nextPos[2]] == "#"
                dir[1], dir[2] = dir[2], -dir[1]
            else
                push!(curPath, (copy(pos), copy(dir)))
                if length(Set(curPath)) < length(curPath)
                    push!(cycles, copy(obPos)) 
                    break
                end
                pos = nextPos
            end
        end
    end
end

filteredCycles = filter(v -> !(1 in v), cycles)
filteredCycles = filter(v -> !(size(playground)[1] in v), filteredCycles)

println("Solution of part 2: ", length(Set(filteredCycles)))