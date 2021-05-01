using LinearAlgebra


# lines = map(collect, readlines("testin11.txt"))
# grid = permutedims(hcat(lines[1:end-1]...)) # only remove last element if it's causing problems

function pprint(M)
    return String.([M[i, :] for i in 1:size(M, 1)])
end


function transform2(M, a, b, c, d)
    seat = M[a,b,c,d]
    # (m,n,p) = size(M)
    # neighborList = [(-1, -1) (-1, 0) (-1, +1) (0, -1) (0, +1) (+1, -1) (+1, 0) (+1, +1)]
    offsetList = setdiff(reshape([[i,j,k,l] for i in -1:1, j in -1:1, k in -1:1, l in -1:1],1,81),[[0,0,0]])
    neighborList = [M[a+i,b+j,c+k,d+l] for (i,j,k,l) in offsetList]
    counts = count(==('#'), neighborList)

    if counts == 3
        return '#'
    elseif seat == '#' && counts == 2
        return '#'
    else
        return '.'
    end

end

function transformM(M)
    (m,n,p,q) = size(M)
    nextM = repeat(['.'],m,n,p,q)
    for i in 2:m-1
        for j in 2:n-1
            for k in 2:p-1
                for l in 2:q-1
                    nextM[i,j,k] = transform2(M, i, j, k, l)
                end
            end
        end
    end
    return nextM
end


function run()
    # board = collect.(split(board, "\n"))
    OLDSIZE = 3
    NEWSIZE = 10
    OFFSET = 4
    ##mat = hcat(map(x -> map(==('#'), collect(x)), tile[2:end])...)

    # lines = map(collect, readlines("in17.txt"))
    lines = map(collect, readlines("testin17.txt"))
    startgrid = permutedims(hcat(lines...))
    grid = repeat(['.'],NEWSIZE,NEWSIZE,NEWSIZE,NEWSIZE)
    # startgrid = map(==('#'), permutedims(hcat(lines...)))
    # grid = Bool.(zeros(NEWSIZE,NEWSIZE))

    k = OFFSET
    l = OFFSET
    for i in 1:OLDSIZE
        for j in 1:OLDSIZE
            grid[OFFSET+i,OFFSET+j,OFFSET,OFFSET] = startgrid[i,j]
        end
    end

    # pprint(grid)
    # print(startgrid)
    display(pprint(grid[:,:,OFFSET,OFFSET]))

    for cycle in 1:1
        grid = transformM(grid)
    end

    for k in 1:NEWSIZE
        for l in 1:NEWSIZE
            # display(grid[:,:,k])
            if count(==('#'), grid[:,:,k,l]) > 0
                println(k)
                display(pprint(grid[:,:,k,l]))
                println()
            end
        end
    end

    println(count(==('#'), grid))

end

run()
