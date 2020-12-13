using LinearAlgebra
using DelimitedFiles
using StatsBase

input = split(read("in4.txt", String), "\n\n")
tre = Dict(Tuple.(split.(splits, r" bag[s] contain "))[1:end-1])

julia> input = split(read("in7.txt", String), "\n")

input = """
light red bags contain 1 bright white bag, 2 muted yellow bags.
dark orange bags contain 3 bright white bags, 4 muted yellow bags.
bright white bags contain 1 shiny gold bag.
muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
dark olive bags contain 3 faded blue bags, 4 dotted black bags.
vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
faded blue bags contain no other bags.
dotted black bags contain no other bags.
"""

match(r"(\w+[ ]?\w+) bags contain (\d+ (\w+[ ]?\w+) bag[s]?,)* \d+ (\w+[ ]?\w+) bag[s].", s)

split.(splits, r" bag[s] contain ")

map(x -> split.(x, r" bag[s]?, "), tre)


Dict(k => map(x -> x[1], eachmatch(r"(\w+ \w+) bag[s]?[.,] ?", v)) for (k,v) in d)

function canreach(node, key, d)
    if node == "no other"
        return false
    end

    if node == key
        return true
    end

    return any(x -> canreach(x, key, d), d[node])
end

function bagcount(node, key, d)
    if node == "no other"
        return 0
    end

    if node == key
        return 1
    end

    return sum(map(x -> canreach(x, key, d), d[node]))
end

map(x -> canreach(x, "shiny gold", d), collect(keys(d)))

function main()
    println(count(l  -> valid(l), input))
end

main()
