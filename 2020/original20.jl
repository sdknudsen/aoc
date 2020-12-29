function parseTile(tile)
    tilenumber = parse(Int, match(r".+ (\d+):", tile[1])[1])
    rows = tile[2:end]
    top = collect(rows[1])
    right = map(x -> x[end], rows)
    bottom = collect(reverse(rows[end]))
    left = reverse(map(x -> x[1], rows))

    return (tilenumber, [top, right, bottom, left])
end

function main()
    input = split.(split(read("testin20.txt", String), "\n\n"), "\n")[1:end-1]
    # input = split.(split(read("in20.txt", String), "\n\n"), "\n")[1:end-1]
    tilePairs = parseTile.(input)
    println(tilePairs)
    # nearbyTickets = map(x -> parse.(Int, x), split.(input[3], ",")[2:end-1])

    n = length(input)
    grid = zeros(n,n)
    center = Int(floor(n / 2))

    first = tilePairs[1][1]
    grid[center,center] = first[1]
    for tile in tilePairs[2:end]
        (equals, ) = equalTransforms(tile[2], grid


        end

    end
end

main()
