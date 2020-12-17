# saidbefore = BitSet()
# countdict = Dict()
nturns = 2020

# startnums = [0,3,6]

function run(startnums)
    turnarr = Int.(zeros(nturns))
    for i in 1:length(startnums)
        # push!(saidbefore, startnums[i])
        # countdict[startnums[i]] = get(countdict, startnums[i], -1) + 1
        turnarr[i] = startnums[i]
    end

    function findlast(turnarr, key, pos)
        for j in pos:-1:1
            # println("turnarr: $turnarr")
            # println("pos: $pos")
            # println("key: $key")
            # println()
            if turnarr[j] == key
                # println("found $key at position $j")
                # println(j)
                # println()
                # println()
                return j
            end
        end
        return Nothing
    end

    for i in (length(startnums) + 1):nturns
        # println("TURN: $i")
        # println("**** lasttime ****")
        # println(i-1)
        # println(turnarr[i-1])
        lasttime = findlast(turnarr, turnarr[i-1], i-1)
        # println("**** blasttime ****")
        blasttime = findlast(turnarr, turnarr[i-1], lasttime-1)
        if blasttime == Nothing
            turnarr[i] = 0
        else
            nextnum = lasttime - blasttime
            turnarr[i] = nextnum
        end
        # push!(saidbefore, nextnum)

        # else
        #     turnarr[i] = 0
        # println("pos: $pos")
        # println("key: $key")
    end
    return turnarr[end]
end

function test(input, expected)
    output = run(input)
    if output != expected
        println("Failure on $input: expected: $expected, actual: $output")
        return false
    else
        return true
    end
end

# println(test([1,3,2], 1))
# println(test([2,1,3], 10))
# println(test([1,2,3], 27))
# println(test([2,3,1], 78))
# println(test([3,2,1], 438))
# println(test([3,1,2], 1836))
println(run([8,13,1,0,18,9]))


# println("turnarr: $turnarr")
# println("last: $(turnarr[end])")

# [0, 3, 6, 0, 3, 3, 1, 0, 4, 0]
