function onesmask(m) replace(m, 'X'=>'0') end
function zerosmask(m) replace(m, 'X'=>'1') end

s = "000000000000000000000000000000001011"
m = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X"
r = parse.(Bool, collect("000000000000000000000000000001001001"))

testinput = """mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
mem[8] = 11
mem[7] = 101
mem[8] = 0
"""

function maskbits(m, s)
    # reverse(digits(s, base=2, pad=16)) # faster
    bstr = parse.(Bool, collect(s))
    om = parse.(Bool, collect(onesmask(m)))
    zm = parse.(Bool, collect(zerosmask(m)))

    r = bstr .| om
    r = r .& zm
    return r
end


function test(input, expected)


print(r == maskbits(m,s))
end



input = split(read("testin14.txt", String), "\n")[1:end-1]
input = split(read("in14.txt", String), "\n")[1:end-1]

function run(input)
    d = Dict()

    mask = "X"
    str = ""
    loc = -1
    for line in input

        println(line)
        if occursin("mask", line)
            maskcom = match(r"mask = (.+)", line)
            mask = maskcom[1]

        else
            memcom = match(r"mem\[(\d+)\] = (\d+)", line)
            loc = parse(Int, memcom[1])
            str = lpad(string(parse(Int, memcom[2]), base=2), 36, '0')
            d[loc] = maskbits(mask,str)
        end
    end
    return d
    # to make this faster, work with ints rather than bitarrays altogether
    # Int64((reverse.(collect(d)[1])).chunks[1])

end

d = run(input)


sum(map(x -> Int64(x.chunks[1]), (reverse.(last.(collect(d))))))
