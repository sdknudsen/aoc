using LinearAlgebra

lines = map(collect, readlines("in3.txt"))
grid = permutedims(hcat(lines...))


forrest = [grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid grid]

n = 323
A = Int.(zeros(n,3 * n))
for i in 0:n-1
    A[i+1,i*3+1] = 1
end

B = Bool.(A)
final = forrest[1:n,1:3*n][B]

count(x -> x == '#', final)






input = readdlm(, '\t', Int, '\n')
s = Set(input)
# s = Set([1721 ,979 ,366 ,299 ,675 ,1456])

function main()
    for i in s
        for j in s
            k = (2020 - i - j)
            if k in s
                println(i * j * k)
                return
            end
        end
    end
end

main()
