using LinearAlgebra



lines = map(collect, readlines("in11.txt"))


function transform(M, i, j)
    seat = M[i,j]
    neighbors = [M[i-1, j-1] M[i-1, j] M[i-1, j+1] M[i, j-1] M[i, j+1] M[i+1, j-1] M[i+1, j] M[i+1, j+1]]

    counts = count(==('#'), neighbors)

    if seat == 'L' && counts == 0
        return '#'
    elseif seat == '#' && counts >= 4
        return 'L'

    else
        return seat

    end
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
                nextM[i,j] = transform(M, i, j)
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



offset = 2
n = size(grid)[1]
n = 323
A = Int.(zeros(n,offset * n))
for i in 0:n-1
    # A[i+1,i*offset+1] = 1
    A[i*offset+1, i+1] = 1
end

B = Bool.(A)
final = forrest[1:n,1:offset*n][B]

count(x -> x == '#', final)



3 - 151
7 - 99
5 - 83
1 - 103
1/2 - 59






# function main()
# end
#
# main()


#julia> x = [1 0 0; 0 0 0]
kron(I(n), [1 0 0; 0 0 0])
