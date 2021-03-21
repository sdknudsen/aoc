# strIn = "32415"

input = "389125467"
# input = "716892543"
arr = parse.(Int, collect(input))

# curr = arr[1]

function step(input, curr)
    # currpos = 1
    currin = curr
    arr = input #??
    currpos = findfirst(==(curr), arr)
    l = length(arr)

    # for count = 1:102
    currpos = findfirst(==(curr), arr)
    pickupindexes = map(x -> mod(x, l) + 1, [currpos:currpos+2;])
    pickedup = arr[pickupindexes]

    # println("cups: $arr")

    arr = arr[sort(collect(setdiff(Set([1:l;]),Set(pickupindexes))))]
    destpos = findfirst(==(curr - 1), arr)

    # println("curr: $curr")
    # println("pick up: $pickedup")

    a = curr - 1
    while typeof(destpos) == Nothing
        # println("a")
        # println(a)
        # println()
        if a < minimum(arr)
            # println("less")
            a = maximum(arr)
        else
            a -= 1
        end

        # println("destpos")
        destpos = findfirst(==(a), arr)
    end

    # println("destination: $a")

    # println()

    # println(destination)

    arr = vcat(arr[1:destpos], pickedup, arr[destpos+1:end])

    currpos = mod(findfirst(==(curr), arr), l) + 1
    curr = arr[currpos]

    return Dict([("cupsin", input), ("keyin", currin), ("pickup", pickedup), ("destination", a), ("cupsout", arr), ("keyout", curr)])

    # end
end

function eqorder(x,y)
    l = length(x)
    a = [x;x]
    a1 = findfirst(==(1), a)
    b = [y;y]
    b1 = findfirst(==(1), b)
    a = a[a1:a1+l-1]
    b = b[b1:b1+l-1]

    return a == b
end

function unittest(input)

    intercups = arr
    interkey = 3

    parsed = split.(split(input, "\n\n"), "\n")
    for p in parsed
        # p = parsed[4]
        # println(p)
        cups_plus = match(r"cups: +(.*)", p[2])[1]
        # println("HERE1")
        # println(cups_plus)
        keycup = parse(Int, match(r".*\((\d+)\).*", cups_plus)[1])
        # println("HERE2")
        # println(keycup)
        cups = parse.(Int, split(filter(x -> x != '(' && x != ')', cups_plus), r" +"))
        # println("HERE3")
        # println(cups)
        pickup = parse.(Int, split(match(r"pick up: (.*)", p[3])[1], ", "))
        destination = parse(Int, match(r"destination: (.*)", p[4])[1])

        # println("HERE")
        actual = step(cups, keycup)

        println("Test Eq")
        # println(actual["cups"])
        # println(cups)

        println(eqorder(actual["cupsin"], cups))
        println(actual["keyin"] == keycup)
        println(actual["pickup"] == pickup)
        println(actual["destination"] == destination)

        println(eqorder(intercups, cups))
        println(interkey == keycup)

        intercups = actual["cupsout"]
        interkey = actual["keyout"]
        # println("expected")
        # println(destination)
        # println()
        println()
    end
end

function run()
    input = "389125467"
    # input = "716892543"
    arr = parse.(Int, collect(input))
    key = 3

    for count = 1:100
        println("-- move $count --")
        println("cups: $arr")
        d = step(arr, key)

        # if this is supposed to be the destination, it's wrong:
        println("destination: $(count + 1)")
        # println(actual["cups"])
        # println(cups)

        key = d["keyout"]
        arr = d["cupsout"]
        # println(arr)
        println()
    end
end

# testinout = split.(split(read("testexpected23.txt", String), "\n\n"), "\n")
testinout = read("testexpected23.txt", String)

# unittest(testinout)
run()

# step(arr, 3)
