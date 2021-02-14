using StatsBase

function getCoord(s)
    coordDict = Dict("e"  => (1,0,-1),
                     "se" => (0,1,-1),
                     "sw" => (-1,1,0),
                     "w"  => (-1,0,1),
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

# main()

# tileMap = Dict([((a,b,-a-b), 0) for a in -10:10, b in -10:10])
# tileMap2 = Dict([((a,b,c), 0) for a in -10:10, b in -10:10, b in -10:10, c in -10:10 if a + b + c == 0])

function blackNeighborCount(tile, grid)
    neighborOffsets = [(1,0,-1), (0,1,-1), (-1,1,0), (-1,0,1), (0,-1,1), (1,-1,0)]
    neighborTiles = map(x -> tile .+ x, neighborOffsets)
    count = sum(map(x -> get(grid, x, 0), neighborTiles))
    # println(neighborTiles)
    #           println("count")
    #           println(count)
    return count
end


function main2()
    input = split(read("in24.txt", String)[1:end-1], "\n")
    all = Dict([((a,b,-a-b), 0) for a in -100:100, b in -100:100])

    startTiles = Dict([(k,v) for (k,v) in countmap(parseLine.(input)) if v % 2 == 1])
    # startTiles = Dict((0, 0, 0) => 1,(2, 0, -2) => 1,(-2, 1, 1) => 1,(-1, -1, 2) => 1,(0, 2, -2) => 1,(-3, 3, 0) => 1,(-3, 2, 1) => 1,(-2, 0, 2) => 1,(3, -3, 0) => 1,(0, -1, 1) => 1)

    println(startTiles)
    # println()
    # println()
    # startTiles = countmap(Set(parseLine.(input)))
    tileMap = merge(all, startTiles)

    # println(tileMap)
    # println(startTiles)
    # println()

    for day in 1:100
        newMap = Dict([((a,b,-a-b), 0) for a in -100:100, b in -100:100])

        # tileMap = Dict([(x,1) for x in parseLine.(input)])
        # println(tileMap)
        # println()

        for tile in keys(tileMap)
            bnc = blackNeighborCount(tile, tileMap)
            if tileMap[tile] == 1 # black
                if bnc == 0 || bnc > 2
                    newMap[tile] = 0
                else
                    newMap[tile] = 1
                end
            else # white
                if bnc == 2
                    newMap[tile] = 1
                else
                    newMap[tile] = 0
                end
                # tileMap = newMap
            end
        end
        # println("here")
        # println(newMap)
        println(sum(values(newMap)))
        tileMap = newMap

    end
end

main2()

# not 3797
