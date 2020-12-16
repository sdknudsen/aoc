function onesmask(m) replace(m, 'X'=>'0') end
function zerosmask(m) replace(m, 'X'=>'1') end

s = "000000000000000000000000000000001011"
m = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X"
r = parse.(Bool, collect("000000000000000000000000000001001001"))

testinput = """mask = 000000000000000000000000000000X1001X
mem[42] = 100
mask = 00000000000000000000000000000000X0XX
mem[26] = 1
"""

function decode(p)
    if p[1] == '0'
        return p[2]
    else
        return p[1]
    end
end


function maskbits(m, s)
    # reverse(digits(s, base=2, pad=16)) # faster
    # bstr = parse.(Bool, collect(s))
    # om = parse.(Bool, collect(onesmask(m)))

    # replace(m, 'X'=>'1')

    # r = bstr .| om

    return String(decode.(collect(zip(collect(m), collect(s)))))
end

# function sumbits(s)
#     c = count(==('X'), collect(s))
#     t = 2^c
#     currsum = 0
#     r = reverse(s)
#     for i in 1:length(s)
#         # println(i)
#         # println(currsum)
#         # println()
#         if r[i] == '1'
#             currsum += 2^(i + c - 1)
#         end
#         if r[i] == 'X'
#             currsum += 2^(i + c - 2)
#         end
#     end
#     return currsum
# end

# sumbits("00000000000000000000000000000001X0XX")

function test(input, expected)
    print(r == maskbits(m,s))
end


function getLocsRec(i, ls, acc)
    if ls == []
        return acc
    end
    if ls[1] == 'X'
        return [getLocsRec(i*2, ls[2:end], map(x -> x + i, acc)); getLocsRec(i*2, ls[2:end], acc)]
    elseif ls[1] == '1'
        return getLocsRec(i*2, ls[2:end], map(x -> x + i, acc))
    elseif ls[1] == '0'
        return getLocsRec(i*2, ls[2:end], acc)
    end
end


input = split(read("testin14.txt", String), "\n")[1:end-1]
input = split(read("in14.txt", String), "\n")[1:end-1]
tin = split(testinput, "\n")[1:end-1]

function run(input)
    d = Dict()

    mask = ""
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
            bits = maskbits(mask,lpad(string(loc,base=2), 36, '0'))
            for l in getLocsRec(1, collect(reverse(bits)), [0])
                d[l] = str
            end
        end
    end
    return d
    # to make this faster, work with ints rather than bitarrays altogether
    # Int64((reverse.(collect(d)[1])).chunks[1])

end

d = run(input)

sum(parse.(Int, last.(collect(d)), base=2))
