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
    gridsize = Int(sqrt(n))
    grid = zeros(gridsize,gridsize)

    ids = Dict(reverse.(collect(indexDict)))
    cornercolindex = findfirst(==(2.0), map(sum, eachcol(mat)))
    grid[cornercolindex, cornercolindex] = ids[cornercolindex]
    unseen = Set(1:n)
    pop!(unseen, cornercolindex)

    edges = findall(!=(4.0), map(sum, eachcol(mat)))
    prev = cornercolindex
    for col in 2:gridsize
        row = 1
        nbrs = findall(==(1.0), mat[:,prev])
        unseennbrs = intersect(nbrs, unseen)
        index = intersect(edges, unseennbrs)[1]
        grid[row, col] = ids[index]
        pop!(unseen, index)
        prev = index

    end

    for row in 2:gridsize
        col = gridsize
        nbrs = findall(==(1.0), mat[:,prev])
        unseennbrs = intersect(nbrs, unseen)
        index = intersect(edges, unseennbrs)[1]
        grid[row, col] = ids[index]
        pop!(unseen, index)
        prev = index
    end

    for col in gridsize-1:1
        row = gridsize
        nbrs = findall(==(1.0), mat[:,prev])
        unseennbrs = intersect(nbrs, unseen)
        index = intersect(edges, unseennbrs)[1]
        grid[row, col] = ids[index]
        pop!(unseen, index)
        prev = index
    end

    for row in gridsize-1:2
        col = 1
        nbrs = findall(==(1.0), mat[:,prev])
        unseennbrs = intersect(nbrs, unseen)
        index = intersect(edges, unseennbrs)[1]
        grid[row, col] = ids[index]
        pop!(unseen, index)
        prev = index
    end

    for i in 2:gridsize-1
        for j in 2:gridsize-1
            ## need to get the upper and left values from grid by looking them up in indexDict
            #?????
            inbrs = findall(==(1.0), mat[:,i-1])
            jnbrs = findall(==(1.0), mat[:,j-1])
            index = intersect(inbrs, jnbrs, unseen)
            grid[i, j] = ids[index]
            pop!(unseen, index)
        end
    end


    # for pair in tileOrientations

    # border = sort(filter(x -> x[2] != 2, countmap(map(x -> x[1], tileOrientations))))
    # borderDf = DataFrame(a = [x[1] for x in border], b = [x[2] for x in border])

    # orientDf = DataFrame(a = [x[1] for x in tileOrientations], tileId = [x[2] for x in tileOrientations])

    # joined = innerjoin(borderDf, orientDf, on = :a)

    # println(countmap(joined[:tileId]))

end

main()
