using CSV
using DataFrames

cd(@__DIR__)

data = CSV.read("INPUT/day01.csv", DataFrame, header = false, ignorerepeated = true, delim = " ")
x = sort(data[:, 1])
y = sort(data[:, 2])

println("Solution of part 1: ", sum(abs.(x .- y)))

sol = 0
for i in 1:length(x)
    sol += x[i] * sum(x[i] .== y)
end

println("Solution of part 2: ", sol)
