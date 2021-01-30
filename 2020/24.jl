using StatsBase

function getCoord(s)
    coordDict = Dict("e" => (1,0,-1),
                     "se" => (0,1,-1),
                     "sw" => (-1,1,0),
                     "w" => (-1,0,1),
                     "nw" => (0,-1,1),
                     "ne" => (1,-1,0))
    return coordDict[s]
end

function parseLine(l)
    return reduce((x,y) -> x.+y, [getCoord(m.match) for m in eachmatch(r"(se|sw|nw|ne|e|w)", l)])
    end

function main()
    # input = split(read("testin24.txt", String)[1:end-2], "\n")
    input = split(read("in24.txt", String)[1:end-1], "\n")
    println(input[end])
    coordset = parseLine.(input)
    println(sort(coordset))
    println(count(x -> x[2] % 2 == 1, countmap(coordset)))


end

main()
