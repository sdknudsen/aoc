function main()
    # input = split.(split(read("testin22.txt", String), "\n\n"), "\n")
    input = split.(split(read("in22.txt", String), "\n\n"), "\n")
    p1 = parse.(Int, input[1][2:end])
    p2 = parse.(Int, input[2][2:end-1]) # only remove last element for in22.txt

    while length(p1) > 0 && length(p2) > 0
        if p1[1] > p2[1]
            p1 = vcat(p1[2:end], p1[1], p2[1])
            p2 = p2[2:end]
        else
            p2 = vcat(p2[2:end], p2[1], p1[1])
            p1 = p1[2:end]
        end
    end


    if length(p1) > length(p2)
        len = length(p1)
        score = sum(reverse(p1) .* [1:len;])
        println(score)
    else
        len = length(p2)
        score = sum(reverse(p2) .* [1:len;])
        println(score)
    end
end



main()

# p1WinList = p1 .> p2
# p2WinList = p2 .> p1
# newP1 = vcat(p1[p1WinList], p2[p1WinList])
# newP2 = vcat(p2[p2WinList], p1[p2WinList])
