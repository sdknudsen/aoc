# input = split(read("testin16.txt", String), "\n")
# input = split(read("in16.txt", String), "\n")


function inRange(n, r)
    return n in r[1] || n in r[2]
end

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

function validTicket(format, ticket)
    all(field -> any(n -> inRange(n, field), ticket), format)
end

function main()
    # input = split.(split(read("testin16.txt", String), "\n\n"), "\n")

    input = split.(split(read("in16.txt", String), "\n\n"), "\n")
    ticketDict = parseTickets(input[1])
    nearbyTickets = map(x -> parse.(Int, x), split.(input[3], ",")[2:end-1]) # -1 only applies to input, not to test intput
    # println(nearbyTickets)
    # println(validTicket.(collect(values(ticketDict)), nearbyTickets))
    # for t in nearbyTickets
    #     println("ticket $t: ")

        #println(filter(t -> !validTicket(collect(values(ticketDict)), t), nearbyTickets))
    res = 0

    ranges = collect(values(ticketDict))
    for ticket in nearbyTickets
        for n in ticket
            if !(any(range -> inRange(n, range), ranges))
                res += n
                println(n)
            end
        end
    end

    println("result: $res")
    # end
    #validTicket.(collect(values(ticketDict)), nearbyTickets)

    # println(values(ticketDict))
    # println()
    # println(nearbyTickets)

    transposed = permutedims(nearbyTickets)
    for ticketDict
end


main()

# captures = map(x -> x.captures, match.(r"(.*): (\d+)-(\d+) or (\d+)-(\d+)", ts))
# pairs = map(x -> (x[1], parse.(Int, x[2:end])), captures)
# ranges = map(x -> (x[1], parse.(Int, x[2:end])), captures)
