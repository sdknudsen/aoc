using LinearAlgebra
using DelimitedFiles
using StatsBase

#splice!(collection, n:n-1, replacement)

input = parse.(Int, split(read("in9.txt", String)))

function hasprop(num, arr)

    ##prop = false
    ##for x in arr
    ##    if (num - x in arr)
    ##        prop = true
    ##    end
    ##end
    ##return prop

    return all(x -> num - x in arr, arr)
end

function main()

    for i in 1:length(input)
        for j in 2:length(input)
            if sum(input[i:j]) == 23278925
                println("i: $i")
                println("j: $j")
                keyarr = input[i:j]
                ans = minimum(keyarr) + maximum(keyarr)
                println(ans)
                return true
            end
        end
    end
end

main()
