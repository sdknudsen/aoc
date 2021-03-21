using LinearAlgebra

# input = split(read("testin16.txt", String), "\n")
# input = split(read("in16.txt", String), "\n")


inRange(n, r) = n in r[1] || n in r[2]

function parseTicket(t)
    capture = match(r"(.*): (\d+)-(\d+) or (\d+)-(\d+)", t).captures
    nums = parse.(Int, capture[2:end])
    ranges = (nums[1]:nums[2], nums[3]:nums[4])
    return (capture[1], ranges)
end

function parseTickets(ts)
    parsed = map(x -> parseTicket(x), ts)
    return Dict(parsed)
end

validTicket(format, ticket) = all(field -> any(n -> inRange(n, field), ticket), format)

function main()
    # input = split.(split(read("testin16.txt", String), "\n\n"), "\n")
    # input = split.(split(read("testin16b.txt", String), "\n\n"), "\n")
    input = split.(split(read("in16.txt", String), "\n\n"), "\n")
    # -1 only applies to input, not to test intput
    # nearbyTickets = map(x -> parse.(Int, x), split.(input[3], ",")[2:end])
    nearbyTickets = map(x -> parse.(Int, x), split.(input[3], ",")[2:end-1])

    ticketDict = parseTickets(input[1])
    valid = Int.(ones(length(nearbyTickets)))

    ranges = collect(values(ticketDict))
    for i in 1:length(nearbyTickets)
        ticket = nearbyTickets[i]
        for n in ticket
            if !(any(range -> inRange(n, range), ranges))
                valid[i] = 0
            end
        end
    end

    validNearby = nearbyTickets[Bool.(valid)]

    ticketFields = collect(ticketDict)

    # println(values(ticketDict))
    # println()
    # println(nearbyTickets)

    validMat = transpose(hcat(validNearby...))
    println(validMat)
    println("___")
    println(ticketFields)
    println("Possibilities:")

    possible = Int.(zeros(length(ticketFields), length(ticketFields)))
    println(size(possible))

    for i in 1:length(ticketFields)
        (name, range) = ticketFields[i]
        println("****************")
        println(name)
        println(range)
        println()
        for j=1:length(ticketFields)
            # println(validMat[:,j])
            if all(x -> inRange(x, range), validMat[:,j])
                possible[i,j] = 1
            end


            #     println(size(validMat))
            #     println(validMat[i,:])

        end
    end

    println()
    println(possible)

    # sum rows
    sum(A, dims=2)
    # sum cols
    sum(A, dims=1)


end


main()


# 0  0  0  0  0  0  0  0  0  0  0  1  0  0  0  0  0  0  0  0
# 0  0  0  0  0  0  0  0  0  0  0  0  1  0  0  0  0  0  0  0
# 0  0  0  0  0  1  0  0  0  0  0  0  0  0  0  0  0  0  0  0
# 0  0  0  0  0  0  0  0  0  0  1  0  0  0  0  0  0  0  0  0
# 0  0  0  1  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
# 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  1  0  0  0
# 0  1  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
# 0  0  0  0  0  0  0  1  0  0  0  0  0  0  0  0  0  0  0  0
# 0  0  0  0  0  0  1  0  0  0  0  0  0  0  0  0  0  0  0  0
# 0  0  0  0  0  0  0  0  0  0  0  0  0  0  1  0  0  0  0  0
# 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  1
# 0  0  1  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
# 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  1  0
# 1  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
# 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  1  0  0  0  0
# 0  0  0  0  0  0  0  0  0  1  0  0  0  0  0  0  0  0  0  0
# 0  0  0  0  0  0  0  0  0  0  0  0  0  1  0  0  0  0  0  0
# 0  0  0  0  1  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
# 0  0  0  0  0  0  0  0  1  0  0  0  0  0  0  0  0  0  0  0
# 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  1  0  0

#                     1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20
# departure date      0  0  0  0  0  0  0  0  0  0  0  1  0  0  0  0  0  0  0  0
# zone                0  0  0  0  0  0  0  0  0  0  0  0  1  0  0  0  0  0  0  0
# price               0  0  0  0  0  1  0  0  0  0  0  0  0  0  0  0  0  0  0  0
# arrival station     0  0  0  0  0  0  0  0  0  0  1  0  0  0  0  0  0  0  0  0
# wagon               0  0  0  1  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
# row                 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  1  0  0  0
# duration            0  1  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
# departure station   0  0  0  0  0  0  0  1  0  0  0  0  0  0  0  0  0  0  0  0
# arrival location    0  0  0  0  0  0  1  0  0  0  0  0  0  0  0  0  0  0  0  0
# train               0  0  0  0  0  0  0  0  0  0  0  0  0  0  1  0  0  0  0  0
# departure track     0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  1
# departure time      0  0  1  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
# route               0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  1  0
# departure location  1  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
# class               0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  1  0  0  0  0
# departure platform  0  0  0  0  0  0  0  0  0  1  0  0  0  0  0  0  0  0  0  0
# arrival platform    0  0  0  0  0  0  0  0  0  0  0  0  0  1  0  0  0  0  0  0
# arrival track       0  0  0  0  1  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
# seat                0  0  0  0  0  0  0  0  1  0  0  0  0  0  0  0  0  0  0  0
# type                0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  1  0  0


# A = [
# 0  0  0  0  0  0  0  0  0  0  0  1  0  0  0  0  0  0  0  0
# 0  0  0  0  0  0  0  1  0  0  0  0  0  0  0  0  0  0  0  0
# 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  1
# 0  0  1  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
# 1  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
# 0  0  0  0  0  0  0  0  0  1  0  0  0  0  0  0  0  0  0  0
# ]
#
# v = [67,107,59,79,53,131,61,101,71,73,137,109,157,113,173,103,83,167,149,163]

# julia> prod(A * v)
# 517827547723
