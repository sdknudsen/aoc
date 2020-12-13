using LinearAlgebra
using DelimitedFiles
using StatsBase

#input = parse.(Int, split(read("t2in10.txt", String)))
#splice!(collection, n:n-1, replacement)

input = parse.(Int, split(read("in10.txt", String)))
input = parse.(Int, split(read("testin10.txt", String)))
input = parse.(Int, split(read("t2in10.txt", String)))

# function hasprop(num, arr)
#
#     ##prop = false
#     ##for x in arr
#     ##    if (num - x in arr)
#     ##        prop = true
#     ##    end
#     ##end
#     ##return prop
#
#     return all(x -> num - x in arr, arr)
# end
#
# function main()
#
#     for i in 1:length(input)
#         for j in 2:length(input)
#             if sum(input[i:j]) == 23278925
#                 println("i: $i")
#                 println("j: $j")
#                 keyarr = input[i:j]
#                 ans = minimum(keyarr) + maximum(keyarr)
#                 println(ans)
#                 return true
#             end
#         end
#     end
# end
#
# main()

# Exponential runtime
function f(xs)

    if length(xs) == 1
        return(1)
    end

    a = xs[1]
    b = xs[2]

    ftail = f(vcat(b, xs[3:end]))
    if a + b <= 3
        return f(vcat(a+b, xs[3:end])) + ftail
    else
        return ftail
    end
end



#
function splitArrays(ls)
    threepos = findfirst(==(3), ls)
    if threepos == nothing
        return [ls]
    else
        vcat([ls[1:threepos-1]], splitArrays(ls[threepos+1:end]))
    end
end


function f(xs, c)

    if length(xs) == 1
        return(count)
    end

    a = xs[1]
    b = xs[2]

    ftail = f(vcat(b, xs[3:end]), c)
    if a + b <= 3
        return f(vcat(a+b, xs[3:end]), c) + ftail
    else
        return ftail
    end

end


prod(f.(splitArrays([1,2,3,4,5,6])))


# filter(x -> length(x) >= 2, splitArrays(diffed))

prod(f.(filter(x -> length(x) >=2, splitArrays(diffed))))





a = sort(vcat(0, maximum(input)+3, input))

diffed = a[2:end] .- a[1:end-1]
onej = count(==(1), diffed) + 1
threej = count(==(3), diffed) + 1
onej * threej

# a = sort(input)
# a = sort(parse.(Int,split(input)))
# zip(a[1:end-1], a[2:end])
# count(x -> x == 3, diffed)
# length(filter(x -> x == 3, diffed))
