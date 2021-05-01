using LinearAlgebra


# lines = map(collect, readlines("testin11.txt"))
# grid = permutedims(hcat(lines[1:end-1]...)) # only remove last element if it's causing problems

function pprint(M)
    return String.([M[i, :] for i in 1:size(M, 1)])
end

function transform(M, i, j)
    seat = M[i,j]
    neighbors = [M[i-1, j-1] M[i-1, j] M[i-1, j+1] M[i, j-1]
                 M[i, j+1] M[i+1, j-1] M[i+1, j] M[i+1, j+1]]

    counts = count(==('#'), neighbors)

    if seat == 'L' && counts == 0
        return '#'
    elseif seat == '#' && counts >= 5
        return 'L'

    else
        return seat

    end
end


function transform2(M, a, b, c)
    seat = M[a,b,c]
    # (m,n,p) = size(M)
    # neighborList = [(-1, -1) (-1, 0) (-1, +1) (0, -1) (0, +1) (+1, -1) (+1, 0) (+1, +1)]
    offsetList = setdiff(reshape([[i,j,k] for i in -1:1, j in -1:1, k in -1:1],1,27),[[0,0,0]])
    neighborList = [M[a+i,b+j,c+k] for (i,j,k) in offsetList]
    counts = count(==('#'), neighborList)

    # for nbr in neighborList
    #     (i,j) = (a,b) .+ nbr
    #     while i >= 1 && i <= m && j >= 1 && j <= n && M[i,j] == '.'
    #         (i,j) = (i,j) .+ nbr
    #     end

    #     if i >= 1 && i <= m && j >= 1 && j <= n && M[i,j] == '#'
    #         counts += 1
    #     end
    # end

    if counts == 3
        return '#'
    elseif seat == '#' && counts == 2
        return '#'
    else
        return '.'
    end

    # if seat == '#'
    #     if counts == 2 || counts == 3
    #         return '#'
    #     else
    #         return '.'
    #     end
    #     # else # seat == '.' && counts == 3
    # elseif seat == '.'
    #     if counts == 3
    #         return '#'
    #     else
    #         return '.'
    #     end
    # end
end

function transformM(M)
    (m,n,p) = size(M)
    nextM = repeat(['.'],m,n,p)
    for i in 2:m-1
        for j in 2:n-1
            for k in 2:p-1
                nextM[i,j,k] = transform2(M, i, j, k)
            end
        end
    end
    return nextM
end

# M2 = copy(M)
# M = transformM(M)
# while M != M2
# M = transformM(M)
# end


#neighborsSet = Set([i-1, j-1] [i-1, j] [i-1, j+1] [i, j-1] [i, j+1] [i+1, j-1] [i+1, j] [i+1, j+1])


function run()
    # board = collect.(split(board, "\n"))
    OLDSIZE = 8
    NEWSIZE = 50
    OFFSET = 23
    ##mat = hcat(map(x -> map(==('#'), collect(x)), tile[2:end])...)

    lines = map(collect, readlines("in17.txt"))
    # lines = map(collect, readlines("testin17.txt"))
    startgrid = permutedims(hcat(lines...))
    grid = repeat(['.'],NEWSIZE,NEWSIZE,NEWSIZE)
    # startgrid = map(==('#'), permutedims(hcat(lines...)))
    # grid = Bool.(zeros(NEWSIZE,NEWSIZE))

    k = OFFSET
    for i in 1:OLDSIZE
        for j in 1:OLDSIZE
            grid[OFFSET+i,OFFSET+j,OFFSET] = startgrid[i,j]
        end
    end

    # pprint(grid)
    # print(startgrid)
    display(pprint(grid[:,:,OFFSET]))

    for cycle in 1:6
    grid = transformM(grid)
    end

    for k in 1:NEWSIZE
        # display(grid[:,:,k])
        if count(==('#'), grid[:,:,k]) > 0
        println(k)
        display(pprint(grid[:,:,k]))
        println()
        end
    end

    println(count(==('#'), grid))
    # for i in 2:NEWSIZE-1
    #     for j in 2:NEWSIZE-1
    #     for k in 2:NEWSIZE-1
    #         grid[i,j,k] = getsymbol(grid,i,j,k)
    #     end
    #     end
    # end

    # fill('.', 100, 93)
    # reshape(filter(!=('\n'), collect(grid)), 10, 10)

    ####[collect(repeat('.', OLDSIZE)) grid collect(repeat('.', OLDSIZE))]

    ####tendots = collect(repeat('.', OLDSIZE))


    ##### lines = map(collect, readlines("testin11.txt"))[1:end-1]

    ####M = [twelvedots; tendots mker tendots; twelvedots]
    ####nextM = []

end

run()

# try
# if M[i,j] == '#'
# end
# catch
# print("here")
# counts = count(==('#'), neighbors)
