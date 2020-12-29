using DataFrames
using StatsBase


function parseTile(tile)
    tilenumber = parse(Int, match(r".+ (\d+):", tile[1])[1])
    rows = tile[2:end]
    top = rows[1]
    right = String(map(x -> x[end], rows))
    bottom = reverse(rows[end])
    left = String(reverse(map(x -> x[1], rows)))

    rotations = map(x -> (x, tilenumber), [top, right, bottom, left])
    flipped = map(x -> (reverse(x), tilenumber), [top, right, bottom, left])
    return [rotations; flipped]
end

function main()
    # input = split.(split(read("testin20.txt", String), "\n\n"), "\n")[1:end-1]
    input = split.(split(read("in20.txt", String), "\n\n"), "\n")[1:end-1]
    tileOrientations = sort(vcat(parseTile.(input)...))

    border = sort(filter(x -> x[2] != 2, countmap(map(x -> x[1], tileOrientations))))
    borderDf = DataFrame(a = [x[1] for x in border], b = [x[2] for x in border])

    orientDf = DataFrame(a = [x[1] for x in tileOrientations], tileId = [x[2] for x in tileOrientations])

    joined = innerjoin(borderDf, orientDf, on = :a)
    println(countmap(joined[:tileId]))
end

main()
