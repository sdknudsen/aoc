using DelimitedFiles
using StatsBase

input = readdlm("in2.txt", '\t', String, '\n')

function adheres(l)
    m = match(r"(\d+)-(\d+) (\w): (\w+)", l)
    lb = parse(Int, m[1])
    ub = parse(Int, m[2])
    letter = m[3][1] # string to char
    password = m[4]
    cm = countmap(password)
    if letter in cm.keys
        lc = cm[letter]
    else
        lc = 0
    end
    return lc >= lb && lc <= ub
end

function main()
    println(count(l  -> adheres(l), input))
end

main()
