using CircularList

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

function run()
    input = "389125467"
    # input = "716892543"

    small_arr = parse.(Int, collect(input))
    # arr = small_arr
    arr = circularlist(small_arr)
    # arr = vcat(small_arr, maximum(small_arr)+1:1000000)

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

# step(arr, 3)
# not 95867432
# the mistake was that I didn't change the initial key
