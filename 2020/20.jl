using DataFrames
using StatsBase

TILESIZE = 10

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


function parseToIdMatPair(tile)
    tilenumber = parse(Int, match(r".+ (\d+):", tile[1])[1])
    rows = map(collect, tile[2:end])
    mat = hcat(map(x -> map(==('#'), collect(x)), tile[2:end])...)
    return (tilenumber, mat)
end

function main()
    input = split.(split(read("testin20.txt", String)[1:end-1], "\n\n"), "\n")
    # input = split.(split(read("in20.txt", String), "\n\n"), "\n")[1:end-1]
    tileOrientations = sort(vcat(parseTile.(input)...))
    tileDict = parseToIdMatPair.(input)

    # list of pairs where first element is tile edge pattern and second is tileid
    println(tileOrientations)

    df = DataFrame(edge = [x[1] for x in tileOrientations], tileId = [x[2] for x in tileOrientations])
    gd = groupby(df,:edge) # get pairs of adjacent tiles


    indexes = unique(sort(map(x -> x[2], tileOrientations)))
    n = length(indexes) # number of tiles
    indexDict = Dict(zip(indexes, 1:n)) # give each tileid an id from 1 to n
    mat = zeros(n,n)

    for g in gd
        group = g[:tileId]

        if length(group) != 2
            # println("**** WARNING ****")
            println(group)
        else
            # println("ADDING")
            println(group)
            a = group[1]
            b = group[2]
            i = indexDict[a]
            j = indexDict[b]

            mat[i,j] = mat[i,j] + 1
            mat[j,i] = mat[j,i] + 1
        end
    end


    nbrPairs = filter(y -> length(y) > 1, map(x -> x[:tileId], collect(gd)))

    mat = mat ./ 2
    gridsize = Int(sqrt(n))
    grid = Int.(zeros(gridsize,gridsize))

    ids = Dict(reverse.(collect(indexDict)))
    cornercolindex = findfirst(==(2.0), map(sum, eachcol(mat)))
    # grid[cornercolindex, cornercolindex] = ids[cornercolindex] # could also have been 1,1, 1,cornercolindex, or cornercolindex,1?
    grid[1, 1] = ids[cornercolindex] # could also have been 1,1, 1,cornercolindex, or cornercolindex,1?
    unseen = Set(1:n)
    pop!(unseen, cornercolindex)

    # Fill in edges with position indexes
    edges = collect(Set(reduce(vcat, filter(y -> length(y) == 1, map(x -> x[:tileId], collect(gd))))))
    edgeNbrPairs = collect(Set(filter(x -> all(y -> y in edges, x), nbrPairs)))
    perimLength = (gridsize-1)*4
    arrangedEdges = Int.(zeros(perimLength))
    prev = ids[cornercolindex]
    arrangedEdges[1] = prev
    for edgeIndx in 2:perimLength
        tilepair = filter(x -> prev in x, edgeNbrPairs)[1]
        edgeNbrPairs = filter(!=(tilepair), edgeNbrPairs)
        tile = filter(y -> y != prev, tilepair)[1]
        arrangedEdges[edgeIndx] = tile
        prev =  tile
    end

    iindexes = [repeat(1:1,gridsize-1); 1:gridsize-1; repeat(gridsize:gridsize,gridsize-1); gridsize:-1:1]
    jindexes = [1:gridsize-1; repeat(gridsize:gridsize,gridsize-1); gridsize:-1:1; repeat(1:1,gridsize-1)]
    for (idx,row,col) in zip(1:perimLength, iindexes, jindexes)
        grid[row, col] = arrangedEdges[idx]
    end

    remainingNbrPairs = nbrPairs

    unseenIds = Set(map(x -> ids[x], collect(unseen)))

    # Fill in body with position indexes
    for i in 2:gridsize-1
        for j in 2:gridsize-1
            above = grid[i-1,j]
            left  = grid[i,j-1]
            anbrs = filter(x -> above in x, remainingNbrPairs)
            lnbrs = filter(x -> left in x, remainingNbrPairs)

            aoptions = filter(!=(above), reduce(vcat, anbrs))
            loptions = filter(!=(left), reduce(vcat, lnbrs))

            selected = intersect(aoptions, loptions, unseenIds)[1]
            grid[i,j] = selected
            unseenIds = filter(!=(selected), unseenIds)
        end
    end
    println(grid)


    img = Bool.(zeros(gridsize * TILESIZE, gridsize * TILESIZE))

    # TODO: rotate grid[1,1] so that it aligns with its neighbors
    # rotate each piece so that it aligns with above and left neighbors
    ###### println(img)

    #####end

    # Insert each tile into the position found previously, rotate and flip to fit
    for i in 1:gridsize
        for j in 1:gridsize
            tileIndex = grid[i,j]
            tile = tileDict[tileIndex]
            if i == 1 && j == 1
                # Insert first tile into the found position, rotating and flipping to fit
                right = grid[i,j+1]
                below = grid[i+1,j]
                # shared edge might still have to be reversed
                sharedEdgeR = map(==('#'), collect(filter(x -> tileIndex in x[:tileId] && right in x[:tileId], collect(gd))[1][:edge][1]))
                sharedEdgeB = map(==('#'), collect(filter(x -> tileIndex in x[:tileId] && below in x[:tileId], collect(gd))[1][:edge][1]))
                for step in 1:4
                    if tile[:,end] == sharedEdgeR || reverse(tile[:,end]) == sharedEdgeR
                        break
                    else
                        rotl90(tile)
                    end
                end
                if !(tile[end,:] == sharedEdgeB || reverse(tile[end,:]) == sharedEdgeB)
                    tile = tile[end:-1:1,:]
                end

                grid[i:i+TILESIZE-1,j:j+TILESIZE-1] = tile
            else # All other tiles
                while(!tileFits)
                    rotateTile
                end
                insertTile(tile, img)
            end
            ## ## need to get the upper and left values from grid by looking them up in indexDict
            ## inbrs = findall(==(1.0), mat[:,i-1])
            ## jnbrs = findall(==(1.0), mat[:,j-1])
            ## index = intersect(inbrs, jnbrs, unseen)
            ## grid[i, j] = ids[index]
            ## pop!(unseen, index)
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
