using LinearAlgebra
using DelimitedFiles
using StatsBase


function check_jmp_op(input)

    seen = falses(length(input))
    pc = 1
    acc = 0

    while seen[pc] == false # && pc != length(input)

        seen[pc] = true

        # keys = map(x -> x[1], collect(eachmatch(r"(\w\w\w):", p)))
        # expected_keys = sort(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid", "cid"])
        # expected_keys1 = sort(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid", "cid"])

        statement = match(r"(\w{3}) (.+)", input[pc])
        # println(statement)
        # println(acc)
        # print(pc)
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

        if pc >= length(input)
            println("DONE")
            println(acc)
            return
        end

    end

    if pc == length(input)
        println("********")
        println(acc)
        # println(pc)
        println("********")
    end

end


function main()
    input = split(read("in8.txt", String), "\n")

    for i in findall(x -> occursin("jmp", x), input)
        println("line: $i")
        currinput = copy(input)
        currinput[i] =  replace(currinput[i], "jmp"=>"nop")
        check_jmp_op(currinput)
    end

    for i in findall(x -> occursin("nop", x), input)
        println("line: $i")
        currinput = copy(input)
        currinput[i] =  replace(currinput[i], "nop"=>"jmp")
        check_jmp_op(currinput)
    end

    # println(count(l  -> valid(l), input))

end

main()
