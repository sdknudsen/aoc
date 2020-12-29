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
    input = split.(split(read("testin20.txt", String)[1:end-1], "\n\n"), "\n")
    # input = split.(split(read("in20.txt", String), "\n\n"), "\n")[1:end-1]
    tileOrientations = sort(vcat(parseTile.(input)...))
    println(tileOrientations)

    df = DataFrame(edge = [x[1] for x in tileOrientations], tileId = [x[2] for x in tileOrientations])
    gd = groupby(df,:edge)


    indexes = unique(sort(map(x -> x[2], tileOrientations)))
    n = length(indexes)
    indexDict = Dict(zip(indexes, 1:n))
    mat = zeros(n,n)

    for g in gd
        group = g[:tileId]

        if length(group) != 2
            println("**** WARNING ****")
            println(group)
        else
            println("ADDING")
            println(group)
            a = group[1]
            b = group[2]
            i = indexDict[a]
            j = indexDict[b]

            mat[i,j] = mat[i,j] + 1
            mat[j,i] = mat[j,i] + 1
        end
    end

    mat = mat ./ 2
    println(mat)
    grid = zeros(Int(sqrt(n)),Int(sqrt(n)))

    ids = Dict(reverse.(collect(indexDict)))
    cornercolindex = findfirst(==(2.0), map(sum, eachcol(mat)))
    grid[cornercolindex, cornercolindex] = ids[cornercolindex]
    unseen = indexes


    edges = findall(==(3.0), map(sum, eachcol(mat)))
    lastneigbors = findall(!=(0.0), mat[cornercolindex, :])
                          = ids[cornercolindex]
    #for

    # for pair in tileOrientations

    # border = sort(filter(x -> x[2] != 2, countmap(map(x -> x[1], tileOrientations))))
    # borderDf = DataFrame(a = [x[1] for x in border], b = [x[2] for x in border])

    # orientDf = DataFrame(a = [x[1] for x in tileOrientations], tileId = [x[2] for x in tileOrientations])

    # joined = innerjoin(borderDf, orientDf, on = :a)

    # println(countmap(joined[:tileId]))

end

main()
