
function getRgx(e, d)
    a = match(r"(\d)+ (\d)+ | (\d)+ (\d)+", e)
    b = match(r"(\d)+ | (\d)+", e)
    c = match(r"(\d)+ (\d)+", e)
    g = match(r"(\d)+", e)
    h = match(r"(\d)+(\d)+(\d)+", e)
    i = match(r"\"(.+)\"", e)

    println("exp")
    println(e)
    println()
    # println(isdefined(key))

    if i != nothing
        println("i")
        return e
    elseif a != nothing
        println("a")
        m = a.captures
        return "$(getRgx(d[m[1]],d))$(getRgx(d[m[2]],d))|$(getRgx(d[m[3]],d))$(getRgx(d[m[4]],d))"
    elseif b != nothing
        println("b")
        m = b.captures
        return "$(getRgx(d[m[1]],d))|$(getRgx(d[m[2]],d))"
    elseif c != nothing
        println("c")
        m = c.captures
        return "$(getRgx(d[m[1]],d))$(getRgx(d[m[2]],d))"
    elseif h != nothing
        println("h")
        m = h.captures
        return "$(getRgx(d[m[1]],d))$(getRgx(d[m[2]],d))$(getRgx(d[m[3]],d))"
    elseif g != nothing
        println("g")
        m = g.match
        return "$(getRgx(d[m],d))"
    else
        println("ERROR")
    end

    # capture = .captures
    # # capture = match(r"(.*): (\d+)-(\d+) or (\d+)-(\d+)", t).captures
    # nums = parse.(Int, capture)
    # ranges = (nums[1] : ??)
    # return (capture[1], ranges)
end

function main()
    input = split.(split(read("testin19.txt", String), "\n\n"), "\n")
    rgx = input[1]
    exps = input[2][1:end-1]
    d = Dict(split.(rgx, ": "))

    println(d)
    println(getRgx("0", d))

    # parsed = map(x -> parseTicket(x), ts)
end

main()
# ^\d+: \d+ \d+ | \d+ \d+$
# "^[0-9]+: [0-9]+ [0-9]+ | [0-9]+ [0-9]+$"
