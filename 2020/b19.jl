using StatsBase

function getRgx(expr, d)
    # println("expr")
    # println(expr)
    # println()

    basecase = match(r"\"(.+)\"", expr)
    if basecase != nothing
        return basecase[1]

    elseif contains(expr, '|')
        (a,b) = split(expr, " | ")
        l = getRgx(a, d)
        r = getRgx(b, d)
        return "($l)|($r)"

    else
        # println("here")
        # println(contains(expr, ' '))

        arr = split(expr, ' ')
        # recs = filter(x -> x == "8" || x == "11", exps)
        mapped = map(x -> getRgx(d[x], d), arr)
        return "(" * join(mapped, ")(") * ")"
    end

end

function main()
    input = split.(split(read("in19.txt", String), "\n\n"), "\n")
    # input = split.(split(read("testin19.txt", String), "\n\n"), "\n")
    rgx = input[1]
    exps = input[2][1:end - 1]  #
    d = Dict(split.(rgx, ": "))
    # d["8"] = "42 | 42 42" # | 42 42 42" # | 42 42 42 42" # | 42 42 42 42 42" # | 42 42 42 42 42 42 | 42 42 42 42 42 42 42 | 42 42 42 42 42 42 42 42 | 42 42 42 42 42 42 42 42 42 | 42 42 42 42 42 42 42 42 42 42 | 42 42 42 42 42 42 42 42 42 42 42"
    # d["11"] = "42 31 | 42 42 31 31" # | 42 42 42 31 31 31" # | 42 42 42 42 31 31 31 31" # | 42 42 42 42 42 31 31 31 31 31 | 42 42 42 42 42 42 31 31 31 31 31 31 | 42 42 42 42 42 42 42 31 31 31 31 31 31 31 | 42 42 42 42 42 42 42 42 31 31 31 31 31 31 31 31 | 42 42 42 42 42 42 42 42 42 31 31 31 31 31 31 31 31 31"

    println("8")
    println(getRgx("8", d))
    println()

    println("11")
    println(getRgx("11", d))
    println()

    println("42")
    println(getRgx("42", d))
    println()

    println("31")
    println(getRgx("31", d))
    println()

    println(d)
    # rexp = Regex("^" * getRgx("0", d) * "\$")
    rexp = Regex("^(" * getRgx("42", d) * "+)(" * getRgx("31", d) * "+)\$")

    # pattern 42 must appear at least one more time than 31

    println(rexp)


    mapped = map(x -> match(rexp, x), exps)
    filtered = filter(x -> x !== nothing, mapped)
    println(filtered)
    println()
    println(map(x -> x[1], exps))
    println(map(x -> x[2], exps))


    # println(countmap(map(x -> match(rexp, x) === nothing, exps)))

    # c = 0
    # for x in exps
    #     if match(rexp, x) !== nothing
    #         c += 1
    #     end
    # end
    # println(c)
    # println(length(filter(x -> match(rexp, x) !== nothing, exps)))

    # parsed = map(x -> parseTicket(x), ts)
end

main()
# ^\d+: \d+ \d+ | \d+ \d+$
# "^[0-9]+: [0-9]+ [0-9]+ | [0-9]+ [0-9]+$"
# not 179
# not 251
