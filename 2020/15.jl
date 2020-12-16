# saidbefore = BitSet()
lastseen = Dict()
nturns = 10 # 30000000

# startnums = [0,3,6]

function run(startnums)
    turnarr = Int.(zeros(nturns))
    for i in 1:length(startnums)
        # push!(saidbefore, startnums[i])
        # countdict[startnums[i]] = get(countdict, startnums[i], -1) + 1
        lastseen[startnums[i]] = [i]
    end
    println(lastseen)

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

    function getlastdiff(key)
        if !(haskey(lastseen,key))
            return 0
        end

        ls = lastseen[key]
        if length(ls) <= 1
            return 0
        else
            return ls[end] - ls[end-1]
        end
    end

    function update(d, i)

    end

    for i in (length(startnums) + 1):nturns
        println(lastseen)
        if i % 10000 == 0
            println(i)
        end
        # println("TURN: $i")
        # println("**** lasttime ****")
        # println(i-1)
        # println(turnarr[i-1])

        turnarr[i] = getlastdiff(turnarr[i-1])
        # update(lastseen, turnarr[i])
        lastseen[turnarr[i]] = append!(get(lastseen, turnarr[i], [0]), i)
        println("turn $i: $(turnarr[i])")

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
println(run([0,3,6]))
# 175594


# println("turnarr: $turnarr")
# println("last: $(turnarr[end])")
