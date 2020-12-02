using DelimitedFiles
using StatsBase

input = readdlm("in2.txt", '\t', String, '\n')

function adheres(l)
    m = match(r"(\d+)-(\d+) (\w): (\w+)", l)
    lb = parse(Int, m[1])
    ub = parse(Int, m[2])
    letter = m[3][1] # string to char
    password = m[4]

    return (password[lb] == letter && password[ub] != letter) ||
        (password[lb] != letter && password[ub] == letter)
end

function main()
    println(count(l  -> adheres(l), input))
end

main()
