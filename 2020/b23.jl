using CircularList

function step(h, d, stepcount)
    shift!(h, 3, :forward)
    c = current(h).data; delete!(h); delete!(d, c)
    b = current(h).data; delete!(h); delete!(d, b)
    a = current(h).data; delete!(h); delete!(d, a)

    curr = current(h)
    destval = current(h).data - 1

    dest = current(h)
    if haskey(d, destval) || destval == a || destval == b || destval == c || destval == 0
        while !haskey(d, destval)
            destval = destval - 1
            if destval <= 0
                destval = maximum([x for x in h])
            end
        end

        dest = d[destval]
        jump!(h,dest)

        d[current(h).data] = current(h)
        insert!(h,a)
        d[current(h).data] = current(h)
        insert!(h,b)
        d[current(h).data] = current(h)
        insert!(h,c)
        d[current(h).data] = current(h)

    else
        # println()
        # print("nokey $destval")


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
                println("cannot find")
            end
            if destval <= 0
                destval = maximum([x for x in h])
                println("reached bottom")
            end
        end

        jump!(h,dest)

        d[current(h).data] = current(h)
        insert!(h,a)
        d[current(h).data] = current(h)
        insert!(h,b)
        d[current(h).data] = current(h)
        insert!(h,c)
        d[current(h).data] = current(h)

        println("reindexing, $stepcount")
        println(length(h))
        println(length(d))
        println(destval)
        d = Dict()
        for entry in 1:length(h)
            d[head(h).data] = head(h)
            forward!(h)
        end
        jump!(h,dest)
    end

    jump!(h,curr)
    forward!(h)
    return(h, d)
end

function run()
    # input = "389125467"
    input = "716892543"

    small_arr = parse.(Int, collect(input))
    # arr = circularlist(small_arr)
    arr = circularlist(vcat(small_arr, maximum(small_arr)+1:1000000))
    lookupdict = Dict()

    curr = current(arr)

    for entry in 1:length(arr)
        if entry % 1000000 == 0
            println(entry)
        end
        lookupdict[head(arr).data] = head(arr)
        forward!(arr)
    end

    jump!(arr,curr)

    # for count = 1:100
    for count = 1:10000000
        if count % 100000 == 0
            println(count)
        end
        # println("-- move $count --")
        # println("cups: $arr")
        (arr, lookupdict) = step(arr, lookupdict, count)
    end

    println("-- move $count --")

    for i in 1:length(arr)
        forward!(arr)
        if current(arr).data == 1
            break
        end
    end

    println(current(arr))
    forward!(arr)
    println(current(arr))
    forward!(arr)
    println(current(arr))
    # end

end

run()
