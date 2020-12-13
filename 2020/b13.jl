input = split(read("testin13.txt", String), "\n")
# input = split(read("in13.txt", String), "\n")
ns = split(input[2], ",")

# diffs = map(x -> parse(Int, x[1]) - x[2], filter(x -> x[1] != "x", collect(zip(ns, poss))))

# typemax(Int64)

# ux+vy = d = gcd(x,y). gcdx(x,y) returns (d,u,v).

# 2 * 7 * 2 + 1 * 13 * -1
# 15

input = split(read("testin13.txt", String), "\n")
ns = split(input[2], ",")


ns = split("7,13,x,x,59,x,31,19", ",") # 1068781
ns = split("17,x,13,19", ",") # 3417
ns = split("67,7,59,61", ",") # 754018
ns = split("67,x,7,59,61", ",") # 779210
ns = split("67,7,x,59,61", ",") # 1261476
ns = split("1789,37,47,1889", ",") # 1202161486

input = split(read("in13.txt", String), "\n")
ns = split(input[2], ",")

function getdiffs(ns)
    poss = [0:length(ns)-1;]
    filtered = filter(x -> x[1] != "x", collect(zip(ns, poss)))
    diffs = map(x -> (parse(BigInt, x[1]), parse(BigInt, x[1]) - x[2]), filtered)
end

diffs = getdiffs(ns)

function f(diffs)
    (n0, a0) = diffs[1]
    for (n, a) in diffs[2:end]
        (d,u,v) = gcdx(n0,n)
        x = n0 * u * a + n * v * a0
        n0 = n * n0
        a0 = x
        # a0 = n0 + x
    end
    ans = (a0 % n0) + n0
    return ans
end

result = f(diffs)
ps = map(x -> x[1], diffs)

result = 906332393333683

function check(result, diffs)
    ps = map(x -> x[1], diffs)
    actual = (ps .- (result .% ps)) .% ps # ps .- (result .% ps)
    expected = map(x -> x[1] % x[2], diffs)
    println(ps)
    println(actual)
    println(expected)
end

check(f(diffs), diffs)

# not 196743477806283
# not 1443606051128903

# ans: 906332393333683
