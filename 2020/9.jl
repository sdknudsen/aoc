using LinearAlgebra
using DelimitedFiles
using StatsBase

#splice!(collection, n:n-1, replacement)
# not 5

xin = split(read("in9.txt", String))
input = parse.(Int, xin)
# input = parse.(Int, split(read("in9.txt", String), "\n"))
# input = parse.(Int, split(read("in9.txt", String), "\n"))


function hasprop(num, arr)

    # println("*****")
    # println(num)
    # println(arr)
    prop = false
    for x in arr
        if (num - x in arr)
            prop = true
        end
    end
    # println(prop)
    #println("*DONE*****")
    return prop
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


# function main()
#     println(count(l  -> valid(l), input))
# end

main()
