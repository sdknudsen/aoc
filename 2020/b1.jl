using DelimitedFiles

input = readdlm("in1.txt", '\t', Int, '\n')
s = Set(input)
# s = Set([1721 ,979 ,366 ,299 ,675 ,1456])

function main()
    for i in s
        for j in s
            k = (2020 - i - j)
            if k in s
                println(i * j * k)
                return
            end
        end
    end
end

main()
