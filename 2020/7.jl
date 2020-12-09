using LinearAlgebra
using DelimitedFiles
using StatsBase




input = split(read("in7.txt", String), "\n")

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

input2 = """
shiny gold bags contain 2 dark red bags.
dark red bags contain 2 dark orange bags.
dark orange bags contain 2 dark yellow bags.
dark yellow bags contain 2 dark green bags.
dark green bags contain 2 dark blue bags.
dark blue bags contain 2 dark violet bags.
dark violet bags contain no other bags.
"""


Dict(Tuple.(split.(input, r" bag[s] contain "))[1:end-1])

Dict(k => map(x -> x[1], eachmatch(r"(\w+ \w+) bag[s]?[.,] ?", v)) for (k,v) in d)

d = Dict(k => map(x -> (x[1], x[2]), eachmatch(r"(\d+) (\w+ \w+) bag[s]?[.,] ?", v)) for (k,v) in tre)





function canreach(node, key, d)

if node == "no other"
return false
end

if node == key
return true
end

return any(x -> canreach(x, key, d), d[node])

end



function bagcount(node, d)

if !(node in keys(d))
return 0
end

if d[node] == []
return 0
end

return sum(map(x -> parse(Int, x[1]) * (1 + bagcount(x[2], d)), d[node]))

end




map(x -> canreach(x, "shiny gold", d), collect(keys(d)))

bagcount("shiny gold", d)



function main()
    println(count(l  -> valid(l), input))
end

main()
