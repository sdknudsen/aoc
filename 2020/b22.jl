function reccombat(p1, p2, seen1, seen2, firstround)
    # println("Player 1's deck: $p1")
    # println("Player 2's deck: $p2")
    # println("Seen 1: $seen1")
    # println("Seen 2: $seen2")

    if length(p1) == 0 || length(p2) == 0
        return (length(p1) > 0, p1, p2) # if a player runs out of cards, the other player wins
    end

    if p1[1] < length(p1) && p2[1] < length(p2)
        # println("== NEW GAME ==")
        (p1winner, _, _) = reccombat(p1[2:p1[1]+1], p2[2:p2[1]+1], Set([p1[2:p1[1]+1]]), Set([p2[2:p2[1]+1]]), true)
    else
        # println("-- NEW ROUND --")
        p1winner = p1[1] > p2[1]
    end

    if p1winner
        p1 = vcat(p1[2:end], p1[1], p2[1])
        p2 = p2[2:end]
    if p1 in seen1 && p2 in seen2
        return (true, p1, p2) # infinite loop, p1 wins
    end

        reccombat(p1, p2, union(Set([p1]), seen1), union(Set([p2]), seen2), false)

    else
        p2 = vcat(p2[2:end], p2[1], p1[1])
        p1 = p1[2:end]
    if p1 in seen1 && p2 in seen2
        return (true, p1, p2) # infinite loop, p1 wins
    end

        reccombat(p1, p2, union(Set([p1]), seen1), union(Set([p2]), seen2), false)
    end
end

function main()
    # input = split.(split(read("testin22.txt", String), "\n\n"), "\n")
    input = split.(split(read("in22.txt", String), "\n\n"), "\n")
    p1 = parse.(Int, input[1][2:end])
    p2 = parse.(Int, input[2][2:end-1]) # only remove last element for in22.txt
    # p2 = parse.(Int, input[2][2:end-1]) # only remove last element for in22.txt

    (p1winner, p1, p2) = reccombat(p1, p2, Set([p1]), Set([p2]), true)

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
