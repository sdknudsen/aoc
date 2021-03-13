using LinearAlgebra

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

    # input = split.(split(read("testin16b.txt", String), "\n\n"), "\n")
    input = split.(split(read("in16.txt", String), "\n\n"), "\n")
    ticketDict = parseTickets(input[1])
    # nearbyTickets = map(x -> parse.(Int, x), split.(input[3], ",")[2:end]) # -1 only applies to input, not to test intput
    nearbyTickets = map(x -> parse.(Int, x), split.(input[3], ",")[2:end-1]) # -1 only applies to input, not to test intput
    # println(nearbyTickets)
    # println(validTicket.(collect(values(ticketDict)), nearbyTickets))
    # for t in nearbyTickets
    #     println("ticket $t: ")

        #println(filter(t -> !validTicket(collect(values(ticketDict)), t), nearbyTickets))
    res = 0
    valid = Int.(ones(length(nearbyTickets)))

    ranges = collect(values(ticketDict))
    for i in 1:length(nearbyTickets)
        ticket = nearbyTickets[i]
        for n in ticket
            if !(any(range -> inRange(n, range), ranges))
                # deleteat!(nmrangeprs,i)
                valid[i] = 0
                # good += ticket
                res += n
                # println(n)
            end
        end
    end

    validNearby = nearbyTickets[Bool.(valid)]

    nmrangeprs = collect(ticketDict)

    # println("result: $res")
    # end
    #validTicket.(collect(values(ticketDict)), nearbyTickets)

    # println(values(ticketDict))
    # println()
    # println(nearbyTickets)

    transposed = transpose(hcat(validNearby...))
    println(transposed)
    println("___")
    println(nmrangeprs)
    println("Possibilities:")

    possible = Int.(zeros(length(nmrangeprs), length(validNearby)))
    println(size(possible))

    for c in 1:length(nmrangeprs)
        (name, range) = nmrangeprs[c]
        # for (name, range) in nmrangeprs
        println("****************")
        println(name)
        println(range)
        println()
        for i=1:length(validNearby)
            println(transposed[:,i])
            if all(j -> inRange(j, range), transposed[:,i])
                println(i)
                possible[c,i] = 1
            end

        end
    end

    println()
    println(possible)
        # mapslices(r -> all(x -> inrange(x, r), r), a, dims = 1)
    # for row in transpose
    #     for n in row
    #         println(n)

    #     end
    # end


    # for (name,range) in ticketDict
    #     println()
    #     println(name)
    #     for i in 1:length(transposed)
    #         if all(n -> inRange(n, range), transposed[i])
    #             # println(field)
    #             print("$i, ")
    #             # count += 1
    #         end
    #     end
    # end
end


main()

# captures = map(x -> x.captures, match.(r"(.*): (\d+)-(\d+) or (\d+)-(\d+)", ts))
# pairs = map(x -> (x[1], parse.(Int, x[2:end])), captures)
# ranges = map(x -> (x[1], parse.(Int, x[2:end])), captures)
