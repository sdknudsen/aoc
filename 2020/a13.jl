input = split(read("in13.txt", String), "\n")

t = parse(Int, input[1])

ns = parse.(Int, filter(!=("x"), split(input[2], ",")))

modstart = t .% ns

# for i in length(modstart)
#     println([modstart[i]:ns[i];])
# end


# (findmin(ns .- modstart .- 1)
diffs = ns .- modstart
key = argmin(diffs)
print(ns[key] * diffs[key])
