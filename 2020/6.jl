using LinearAlgebra
using DelimitedFiles

map(x -> intersect(Set.(x)), split.(collect(input), "\n"))using StatsBase

input = split(read("testin6.txt", String), "\n\n")

sum(length.(filter.(x -> x != '\n', Set.(collect.(input)))))


split.(collect(input), "\n")


reduce.(intersect, map(x -> intersect(Set.(x)), split.(collect(input), "\n")))


sum(length.(reduce.(intersect, map(x -> intersect(Set.(x)), split.(collect(input), "\n")))))

#not 3309
# missing dmorsuy

sum(length.(reduce.(intersect, map(x -> Set.(x), split.(collect(input), "\n")))))



# haskell works (it was 3316):
# Prelude Data.Set> sum $ Prelude.map size (Prelude.map (Prelude.foldr1 intersection) (Prelude.map (Prelude.map fromList) ls))

# join(collect(s))

# The problem was that there was no \n\n at the end and so the last input wasn't recognized
