using CSV
using DataFrames

cd(@__DIR__)

data = CSV.read("INPUT/day02.csv", DataFrame, header = false, ignorerepeated = true, delim = " ")

safeReports = 0
for ind in 1:nrow(data)
    x = collect(skipmissing(data[ind, :]))
    for drop in 1:length(x)
        y = x[setdiff(1:end, drop)]
        if all(abs.(diff(y)) .<= 3) && (all(diff(y) .> 0) || all(diff(y) .< 0))
            safeReports += 1
            break
        end
    end
end

println("Solution of part 2:", safeReports)
