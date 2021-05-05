function reccombat(p1, p2, slow1, slow2, oddstep)
    # run two games, one twice as fast? if the two games have the same cards, player 1 wins

    if length(p1) == 0 || length(p2) == 0
        return p1 > 0

    elseif p1[1] <= length(p1) && p2[1] <= length(p2)
        if oddstep
        reccombat(p1[1:p1[1]], p2[1:p2[1]], )
        else

    elseif p1[1] > p2[1]
        p1 = vcat(p1[2:end], p1[1], p2[1])
        p2 = p2[2:end]
        reccombat(p1, p2)

    else
        p2 = vcat(p2[2:end], p2[1], p1[1])
        p1 = p1[2:end]
        reccombat(p1, p2)
    end
end

function main()
    input = split.(split(read("testin22.txt", String), "\n\n"), "\n")
    # input = split.(split(read("in22.txt", String), "\n\n"), "\n")
    p1 = parse.(Int, input[1][2:end])
    p2 = parse.(Int, input[2][2:end-1]) # only remove last element for in22.txt

    p1winner = reccombat(p1, p2)

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
