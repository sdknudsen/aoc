using LinearAlgebra
using DelimitedFiles
using StatsBase

input = split(read("in8.txt", String), "\n")


function main()

    seen = falses(length(input))
    pc = 1
    acc = 0

    while seen[pc] == false

        seen[pc] = true

        statement = match(r"(\w{3}) (.+)", input[pc])
        println(statement)
        println(acc)
        action = statement[1]
        n = parse(Int, statement[2])

        if action == "jmp"
            pc += n

        elseif action == "acc"
            acc += n
            pc += 1

        elseif action == "nop"
            pc += 1

        end

    end
end

main()
