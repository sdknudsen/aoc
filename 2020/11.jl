using LinearAlgebra


# lines = map(collect, readlines("testin11.txt"))
# grid = permutedims(hcat(lines[1:end-1]...)) # only remove last element if it's causing problems

lines = map(collect, readlines("in11.txt"))
grid = permutedims(hcat(lines...))

function pprint(M)
    return String.([M[i, :] for i in 1:size(M, 1)])
end

function format(M)
    (m,n) = size(M) .+ (2,2)
    filled = fill('.', m, n)
    for i in 1:m-2
        for j in 1:n-2
            filled[i+1,j+1] = grid[i,j]
        end
    end
    return filled
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


function transform2(M, a, b)
    seat = M[a,b]

    if seat == '.'
        return '.'
    end

    (m,n) = size(M)

    neighborList = [(-1, -1) (-1, 0) (-1, +1) (0, -1) (0, +1) (+1, -1) (+1, 0) (+1, +1)]
    counts = 0

    for nbr in neighborList
        (i,j) = (a,b) .+ nbr
        while i >= 1 && i <= m && j >= 1 && j <= n && M[i,j] == '.'
            (i,j) = (i,j) .+ nbr
        end

        if i >= 1 && i <= m && j >= 1 && j <= n && M[i,j] == '#'
            counts += 1
        end
    end

    if seat == 'L' && counts == 0
        return '#'
    elseif seat == '#' && counts >= 5
        return 'L'

    else
        return seat

    end
end

function transformM(M)
    nextM = copy(M)
    (m,n) = size(M)
    for i in 2:m-1
        for j in 2:n-1
            nextM[i,j] = transform2(M, i, j)
        end
    end
    return nextM
end

# M2 = copy(M)
# M = transformM(M)
# while M != M2
# M = transformM(M)
# end


pprint(transformM(format(grid)))
    #neighborsSet = Set([i-1, j-1] [i-1, j] [i-1, j+1] [i, j-1] [i, j+1] [i+1, j-1] [i+1, j] [i+1, j+1])

function mask(M,a,b)
    (m,n) = size(M)
    mat = fill(false, m, n)


    for i in 1:m
        for j in 1:n
            # if i == a || j == b || i // j == a // b
            abscorner = abs.([i,j] - [a,b])
            println(corner)
            if i == a || j == b || abscorner[1] == abscorner[2]

                mat[i,j] = true
            end
        end
    end
    return mat

end

function run()
    board = collect.(split(board, "\n"))


    grid = permutedims(hcat(lines...))

    fill('.', 100, 93)


    reshape(filter(!=('\n'), collect(board)), 10, 10)


    [collect(repeat('.', 10)) M collect(repeat('.', 10))]

    tendots = collect(repeat('.', 10))

    twelvedots1 = collect(repeat('.', 12))
    twelvedots = reshape(twelvedots1, (1, length(twelvedots1)))

    lines = map(collect, readlines("testin11.txt"))[1:end-1]
    mker = reshape(reduce(vcat, lines), 10, 10)

    M = [twelvedots; tendots mker tendots; twelvedots]
    nextM = []


    found = false
    while found == false

        # print(M)

        nextM = copy(M)
        (m,n) = size(M)
        for i in 2:m-1
            for j in 2:n-1
                nextM[i,j] = transform2(M, i, j)
            end
        end

        if M == nextM
            println(count(==('#'), M))
            found = true
            break
        end

        M = nextM
    end
end

# try
# if M[i,j] == '#'
# end
# catch
# print("here")
# counts = count(==('#'), neighbors)
