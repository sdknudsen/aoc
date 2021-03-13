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

function main()
    input = split.(split(read("in19.txt", String), "\n\n"), "\n")
    # input = split.(split(read("testin19.txt", String), "\n\n"), "\n")
    rgx = input[1]
    exps = input[2][1:end-1]
    d = Dict(split.(rgx, ": "))

    println(d)
    rexp = Regex("^" * getRgx("0", d) * "\$")

    println(rexp)
    println(countmap(map(x -> match(rexp, x) === nothing, exps)))
    # println(length(filter(x -> match(rexp, x) !== nothing, exps)))

    # parsed = map(x -> parseTicket(x), ts)
end

main()
# ^\d+: \d+ \d+ | \d+ \d+$
# "^[0-9]+: [0-9]+ [0-9]+ | [0-9]+ [0-9]+$"
