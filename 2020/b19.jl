using StatsBase

function getRgx(expr, d)

    basecase = match(r"\"(.+)\"", expr)
    if basecase != nothing
        return basecase[1]

    elseif contains(expr, '|')
        (a,b) = split(expr, " | ")
        l = getRgx(a, d)
        r = getRgx(b, d)
        return "($l)|($r)"

    else
        arr = split(expr, ' ')
        mapped = map(x -> getRgx(d[x], d), arr)
        return "(" * join(mapped, ")(") * ")"
    end

end

function isValid(rexp, x, d)

    if match(rexp, x) === nothing
        return false
    end

    fourtytwo = match(rexp, x)[:fourtytwo]
    fourtytwo_count = length(collect(eachmatch(Regex(getRgx("42", d)), fourtytwo)))

    thirtyone = match(rexp, x)[:thirtyone]
    thirtyone_count = length(collect(eachmatch(Regex(getRgx("31", d)), thirtyone)))
    # println("full: $x")
    # println("42:   $fourtytwo")
    # println("31:   $thirtyone")

    return fourtytwo_count > thirtyone_count
end

function main()
    input = split.(split(read("in19.txt", String), "\n\n"), "\n")
    # input = split.(split(read("testin19b.txt", String), "\n\n"), "\n")
    rgx = input[1]
    exps = input[2][1:end]
    d = Dict(split.(rgx, ": "))

    rexp = Regex("^(?<fourtytwo>" * getRgx("42", d) * ")+(?<thirtyone>" * getRgx("31", d) * ")+\$")

    rexp_full = Regex("^(?<fourtytwo>(" * getRgx("42", d) * "+))((?<thirtyone>" * getRgx("31", d) * "+))\$")

    println(count(map(x -> isValid(rexp_full, x, d), exps)))
end

main()
