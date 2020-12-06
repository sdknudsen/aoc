using LinearAlgebra
using DelimitedFiles
using StatsBase

# not 115, it's too high
# input = split(read("in4.txt", String), "\n\n")
# input = split(read("valid.txt", String), "\n\n")
input = split(read("in4.txt", String), "\n\n")

#ls = map(x -> split(x, r"[\n ]"), input)
#map(x -> Dict(Tuple.(split.(x, ":"))), ls)

# lines = map(collect, readlines("testin4.txt"))
# lines = map(collect, readlines("in3.txt"))
# grid = permutedims(hcat(lines...))


# byr (Birth Year) - four digits; at least 1920 and at most 2002.
# iyr (Issue Year) - four digits; at least 2010 and at most 2020.
# eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
# hgt (Height) - a number followed by either cm or in:
#
#     If cm, the number must be at least 150 and at most 193.
#     If in, the number must be at least 59 and at most 76.
#
# hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
# ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
# pid (Passport ID) - a nine-digit number, including leading zeroes.

# if length(setdiff(keys, ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid", "cid"])) > 0
# keys = map(x -> x[1], collect(eachmatch(r"(\w\w\w):", p)))    if !reqfields

function valid(p)

    reqfields = occursin("byr:", p) &&
        occursin("iyr:", p) &&
        occursin("eyr:", p) &&
        occursin("hgt:", p) &&
        occursin("hcl:", p) &&
        occursin("ecl:", p) &&
        occursin("pid:", p)

    keys = map(x -> x[1], collect(eachmatch(r"(\w\w\w):", p)))
    expected_keys = sort(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid", "cid"])
    expected_keys1 = sort(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid", "cid"])
    if length(setdiff(keys, )) > 0
        return false
    end

    if !reqfields
        return false
    end

    byr = match(r"byr:(\d\d\d\d)", p)
    iyr = match(r"iyr:(\d\d\d\d)", p)
    eyr = match(r"eyr:(\d\d\d\d)", p)

    hgt = match(r"hgt:(\d\d\d?)(cm|in)", p)
    hcl = match(r"hcl:#[a-f0-9]{6}", p)
    ecl = match(r"ecl:(amb|blu|brn|gry|grn|hzl|oth)", p)
    pid = match(r"pid:[0-9]{9}", p)

    if byr === nothing || iyr === nothing || eyr === nothing || hgt === nothing ||
        hcl === nothing || ecl === nothing || pid === nothing
        return false
    end

    hgtnum = parse(Int, hgt[1])
    validhgt = (hgt[2] == "cm" &&
                hgtnum >= 150 && hgtnum <= 193) ||
                (hgt[2] == "in" && hgtnum >= 59 && hgtnum <= 76)

    if !validhgt
        return false
    end

    validnums = parse(Int, byr[1]) >= 1920 && parse(Int, byr[1]) <= 2002 &&
        parse(Int, iyr[1]) >= 2010 && parse(Int, iyr[1]) <= 2020 &&
        parse(Int, eyr[1]) >= 2020 && parse(Int, eyr[1]) <= 2030

    if !validnums
        return false
    end

    println(p)
    println()
    println()
    return true

end


function main()
    println(count(l  -> valid(l), input))
end

main()
