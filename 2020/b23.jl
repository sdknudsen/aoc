using CircularList

#####
function step(h)
    shift!(h, 3, :forward)
    c = current(h).data; delete!(h); b = current(h).data; delete!(h); a = current(h).data; delete!(h)
    curr = current(h)
    destval = current(h).data - 1

    dest = current(h)

    while(current(h).data != destval)
        for i in 1:length(h)
            forward!(h)
            if current(h).data == destval
                dest = current(h)
                break
            end
        end
        if dest.data != destval
            destval = destval - 1
        end
        if destval <= 0
            destval = maximum([x for x in h])
        end
    end

    insert!(h,a)
    insert!(h,b)
    insert!(h,c)

    jump!(h,curr)
    forward!(h)
end

# julia> forward!(h)
# CircularList.List(8,9,1,2,5,4,6,7,3)
#
# julia> a = head(h); delete!(h)
# CircularList.List(3,9,1,2,5,4,6,7)
#
# julia> forward!(h); b = head(h); delete!(h)
# CircularList.List(3,1,2,5,4,6,7)
#
# julia> forward!(h); c = head(h); delete!(h)
# CircularList.List(3,2,5,4,6,7)
#
# julia> [a;b;c]
# 3-element Array{CircularList.Node{Int64},1}:
#  CircularList.Node(8)
#  CircularList.Node(9)
#  CircularList.Node(1)
#
# julia> current(h)
####

function step_old(input)
    # currpos = 1
    currin = curr
    arr = input #??
    currpos = findfirst(==(curr), arr)
    l = length(arr)

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
        actual = step(cups)

        println("Test Eq")
        # println(actual["cups"])
        # println(cups)

        println(eqorder(actual["cupsin"], cups))
        println(actual["keyin"] == keycup)
        println(actual["pickup"] == pickup)
        println(actual["destination"] == destination)

        # println(eqorder(intercups, cups))
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

    small_arr = parse.(Int, collect(input))
    # arr = small_arr
    arr = circularlist(small_arr)
    # arr = vcat(small_arr, maximum(small_arr)+1:1000000)
    # key = 7
    # key = 3

    # d = Dict()
    for count = 1:100
    # for count = 1:10000000
        ######if count % 2 == 0
        ######    println(count)
        ######    onepos = findfirst(==(1), arr)
        ######    println(arr[onepos])
        ######    println(arr[onepos+1])
        ######    println(arr[onepos+2])
        ######    println()
        ######end
        # println("-- move $count --")
        # println("cups: $arr")
        arr = step(arr)

        # TODO
        ###dest = d["destination"]
        ###pick = d["pickup"]
        ###println("pickup: $(pick)")
        ###println("destination: $(dest)")
        # return Dict([("cupsin", input), ("keyin", currin), ("pickup", pickedup), ("destination", a), ("cupsout", arr), ("keyout", curr)])
        # println(actual["cups"])
        # println(cups)

        ###key = d["keyout"]
        ###arr = d["cupsout"]
        # println(arr)
        # println()
    end

    println("-- move $count --")
    # println("cups: $arr")
    # dest = d["destination"]
    # pick = d["pickup"]
    # println("pickup: $(pick)")
    # println("destination: $(dest)")

    for i in 1:length(arr)
        forward!(arr)
        if current(arr).data == 1
            break
        end
    end
    # if current(arr).data == 1
    println(current(arr))
    forward!(arr)
    println(current(arr))
    forward!(arr)
    println(current(arr))
    # end

end

# testinout = split.(split(read("testexpected23.txt", String), "\n\n"), "\n")
# testinout = read("testexpected23.txt", String)

# unittest(testinout)
run()

# step(arr, 3)
# not 95867432
# the mistake was that I didn't change the initial key
