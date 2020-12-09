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

        # keys = map(x -> x[1], collect(eachmatch(r"(\w\w\w):", p)))
        # expected_keys = sort(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid", "cid"])
        # expected_keys1 = sort(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid", "cid"])

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

        # elseif action == "nop"
        #     nop += n
        # end

    end
end


# function main()
#     println(count(l  -> valid(l), input))
# end

main()
