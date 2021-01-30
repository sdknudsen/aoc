# strIn = "32415"

input = "389125467"

arr = parse.(Int, collect(input))
# currpos = 1

for count = 1:100
    curr = arr[1]
    pickedup = arr[2:4]
    arr = vcat(curr, arr[5:end])
    destination = findfirst(==(curr - 1), arr)

    a = curr
    while typeof(destination) == Nothing
        a -= 1
        if a < minimum(arr)
            a = maximum(arr)
        else
            destination = findfirst(==(a - 1), arr)
        end
    end

    # arr = vcat(arr[destination], pickedup, arr[destination+1:end], arr[2:destination-1], curr)
    arr = vcat(arr[2:destination], pickedup, arr[destination+1:end], curr)

    # currpos += 1

end
