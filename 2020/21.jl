using StatsBase

function parselines(splitIn)
    foods = split(splitIn[1], " ")
    allergens = split(splitIn[2][1:end-1], ", ")

    return map(x -> (x, foods), allergens)
    # return vec([(f,a) for f in foods, a in allergens])
    # return vec([(f,a) for f in foods, a in allergens])
    # in main: vcat(parselines.(input)...)
end

function getFoods(splitIn)
    return split(splitIn[1], " ")
end


function main()
    input = split.(split(read("in21.txt", String)[1:end-1], "\n"), " (contains ")
    # input = split.(split(read("testin21.txt", String)[1:end-1], "\n"), " (contains ")
    mappings = vcat(parselines.(input)...)
    allergens = unique(map(x -> x[1], mappings))

    # redmappings = map(a -> reduce(intersect, map(x -> x[2], filter(x -> x[1] == a, mappings))), allergens)
    redmappings = map(a -> (a, reduce(intersect, map(x -> x[2], filter(x -> x[1] == a, mappings)))), allergens)

    println(redmappings)

end

main()


 # ("eggs", ["bkgmcsx"])
 # ("soy", ["jspkl"])
 # ("peanuts", ["tjtgbf"])
 # ("dairy", ["vpzxk"])
 # ("wheat", ["hdcj"])
 # ("sesame", ["rjdqt"])
 # ("fish", ["qfzv"])
 # ("shellfish", ["hbnf"])


# map(x -> (x[1], filter(y -> !(y in Set(["bkgmcsx",  "jspkl", "tjtgbf", "vpzxk"])), x[2])), redmappings)

# vpzxk,bkgmcsx,qfzv,tjtgbf,rjdqt,hbnf,jspkl,hdcj"
