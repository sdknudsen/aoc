function reccombat(p1, p2, slow1, slow2, seen1, seen1, oddstep)
    # println("Player 1's deck: $p1")
    # println(p1)
    # println("Player 2's deck: $p2")
    # println(p2)
    # println("Slow1 deck: $slow1")
    # println("Slow2 deck: $slow2")

    # run two games, one twice as fast? if the two games have the same cards, player 1 wins
    if oddstep && ((p1 == slow1 && p2 == slow2) || (p1 in seen1 && p2 in seen2))
        return (true, p1, p2) # infinite loop, p1 wins
    end

    if oddstep
        if slow1[1] > slow2[1]
            slow1 = vcat(slow1[2:end], slow1[1], slow2[1])
            slow2 = slow2[2:end]
        else
            slow2 = vcat(slow2[2:end], slow2[1], slow1[1])
            slow1 = slow1[2:end]
        end
    end

    if oddstep && ((p1 == slow1 && p2 == slow2) || (p1 == orig1 && p2 == orig2))
        return (true, p1, p2) # infinite loop, p1 wins
    end

    if length(p1) == 0 || length(p2) == 0
        return (length(p1) > 0, p1, p2) # if a player runs out of cards, the other player wins
    end

    if p1[1] < length(p1) && p2[1] < length(p2)
        # println("== NEW GAME ==")
        (p1winner, _, _) = reccombat(p1[2:p1[1]+1], p2[2:p2[1]+1], p1[2:p1[1]+1], p2[2:p2[1]+1], p1[2:p1[1]+1], p2[2:p2[1]+1], false)
    else
        # println("-- NEW ROUND --")
        p1winner = p1[1] > p2[1]
    end

    if p1winner
        p1 = vcat(p1[2:end], p1[1], p2[1])
        p2 = p2[2:end]
        reccombat(p1, p2, slow1, slow2, orig1, orig2, !oddstep)

    else
        p2 = vcat(p2[2:end], p2[1], p1[1])
        p1 = p1[2:end]
        reccombat(p1, p2, slow1, slow2, orig1, orig2, !oddstep)
    end
end

function main()
    input = split.(split(read("testin22.txt", String), "\n\n"), "\n")
    # input = split.(split(read("in22.txt", String), "\n\n"), "\n")
    p1 = parse.(Int, input[1][2:end])
    p2 = parse.(Int, input[2][2:end]) # only remove last element for in22.txt
    # p2 = parse.(Int, input[2][2:end-1]) # only remove last element for in22.txt

    (p1winner, p1, p2) = reccombat(p1, p2, p1, p2, p1, p2, false)

    if p1winner
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

# it's not 7981
# it's not 9142
