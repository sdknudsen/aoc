using LinearAlgebra

lines = map(collect, readlines("in3.txt"))
grid = permutedims(hcat(lines...))


forrest = [grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid]

offset = 2
n = size(grid)[1]
n = 323
A = Int.(zeros(n,offset * n))
for i in 0:n-1
    # A[i+1,i*offset+1] = 1
    A[i*offset+1, i+1] = 1
end

B = Bool.(A)
final = forrest[1:n,1:offset*n][B]

count(x -> x == '#', final)



3 - 151
7 - 99
5 - 83
1 - 103
1/2 - 59






# function main()
# end
#
# main()


#julia> x = [1 0 0; 0 0 0]
kron(I(n), [1 0 0; 0 0 0])
