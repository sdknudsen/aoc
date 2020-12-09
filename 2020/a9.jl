using LinearAlgebra
using DelimitedFiles
using StatsBase

input = parse.(Int, split(read("in9.txt", String)))

function hasprop(num, arr)

    prop = false
    for x in arr
        if (num - x in arr)
            prop = true
        end
    end
    return prop
end

function main()

    for i in 26:(length(input)-1)
        # println(i)
        if !hasprop(input[i], input[i-25:i-1])
            println("FAILED")
            # println(i)
            println(input[i])
        end
    end
end


# function main()
#     println(count(l  -> valid(l), input))
# end

main()
