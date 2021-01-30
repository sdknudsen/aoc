# strIn = "32415"

input = "389125467"

function run(input)
    arr = parse.(Int, collect(input))
    l = length(arr)
    # currpos = 1
    curr = arr[1]


    #for count = 1:100
    currpos = findfirst(==(curr), arr)
    pickupindexes = map(x -> mod(x, l) + 1, [currpos:currpos+2;])
    pickedup = arr[pickupindexes]
    arr = arr[sort(collect(setdiff(Set([1:l;]),Set(pickupindexes))))]
    destpos = findfirst(==(curr - 1), arr)

    println("cups: $arr")
    println("curr: $curr")
    println("pick up: $pickedup")

    a = curr - 1
    while typeof(destpos) == Nothing
        # println("a")
        # println(a)
        # println()
        if a < minimum(arr)
            # println("less")
            a = maximum(arr)
        end

        # println("destpos")
        destpos = findfirst(==(a), arr)
        a -= 1
    end

    println("destination: $a")

    println()

    # println(destination)

    arr = vcat(arr[1:destpos], pickedup, arr[destpos+1:end])

    currpos = findfirst(==(curr), arr) + 1
    curr = arr[currpos]

    # end
end

function unittest(input, expected)
    ???

        end
