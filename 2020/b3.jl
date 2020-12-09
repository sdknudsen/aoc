using LinearAlgebra

lines = map(collect, readlines("in3.txt"))
grid = permutedims(hcat(lines...)) .== '#'
(m,n) = size(grid)
offset = 3

# Create repeated grid and truncate
# kron is the Kronecker or outer product
repeatmat = ones(1, Int(ceil(m * offset / n)))
forrest = Bool.(kron(repeatmat, grid))[:, 1:offset * m]

# Create bitmask for relevant entries
mask = kron(I(n), [1 0 0])[1:m, 1:offset * m]

sum(mask .& forrest)



# 3 - 151
# 7 - 99
# 5 - 83
# 1 - 103
# 1/2 - 59


# function main()
# end
#
# main()
