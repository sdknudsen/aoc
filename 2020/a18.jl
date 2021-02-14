using LinearAlgebra

# 10741371449 is too low

function ⊕(a,b)
    return a * b
end

function main()
    input = split(read("in18.txt", String), "\n")[1:end-1]
    sums = map(x -> eval(Meta.parse(replace(x, '*' => '⊕'))), input)
    sm = sum(sums)
    println(sm)
end

main()
