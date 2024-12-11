cd( @__DIR__)

input = readlines("./INPUT/day10.txt")
input = [collect(ch) for ch in input]
input = reduce(hcat, input)
input = parse.(Int, input)
input = permutedims(input)

playground = fill(-1, size(input)[1] + 2, size(input)[2] + 2)
playground[1 .+ (1:size(input)[1]), 1 .+ (1:size(input)[2])] .= input

hikes = []
dirs = CartesianIndex.([(1,0), (-1, 0), (0,1), (0,-1)])
starts = findall(x -> x == 0, playground)
score = 0

for start in starts 
    paths = [[start]]
    newPaths = []
    for l in 1:9
        println(l)
        for path in paths
            for dir in dirs
                dummy = path[end] + dir
                if playground[dummy] == l
                    push!(newPaths, vcat(path, dummy))
                end
            end
        end
        paths = newPaths
        newPaths = []
    end
    hikes = vcat(hikes, paths)
    score += length(unique(getindex.(paths, 10)))
end

println("Solution of part 1: ", score)
println("Solution of part 2: ", length(hikes))