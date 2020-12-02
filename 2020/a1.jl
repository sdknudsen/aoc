using DelimitedFiles

input = readdlm("in1.txt", '\t', Int, '\n')

# findfirst(isequal(3), [3,2])
# s = Set([])
s = Set(input)
#s = Set([1721 ,979 ,366 ,299 ,675 ,1456])

for i in s
if (2020 - i) in s
println(i * (2020 - i))
break
end
end

