using StatsBase

function parselines(splitIn)
    foods = split(splitIn[1], " ")
    allergens = split(splitIn[2][1:end-1], ", ")

    return map(x -> (x, foods), allergens)
    # return vec([(f,a) for f in foods, a in allergens])
    # return vec([(f,a) for f in foods, a in allergens])
    # in main: vcat(parselines.(input)...)
end



# tilenumber = parse(Int, match(r".+ (\d+):", tile[1])[1])
# rows = tile[2:end]
# top = rows[1]
# right = String(map(x -> x[end], rows))
# bottom = reverse(rows[end])
# left = String(reverse(map(x -> x[1], rows)))

# rotations = map(x -> (x, tilenumber), [top, right, bottom, left])
# flipped = map(x -> (reverse(x), tilenumber), [top, right, bottom, left])
# return [rotations; flipped]

function getFoods(splitIn)
    return split(splitIn[1], " ")
end


function main()
    input = split.(split(read("in21.txt", String)[1:end-1], "\n"), " (contains ")
    # input = split.(split(read("testin21.txt", String)[1:end-1], "\n"), " (contains ")
    mappings = vcat(parselines.(input)...)
    allergens = unique(map(x -> x[1], mappings))

    redmappings = map(a -> reduce(intersect, map(x -> x[2], filter(x -> x[1] == a, mappings))), allergens)
    # redmappings = map(a -> (a, reduce(intersect, map(x -> x[2], filter(x -> x[1] == a, mappings)))), allergens)

    allfoods = vcat(getFoods.(input)...)

    possiblefoods = Set(vcat(redmappings...))

    safefoods = setdiff(Set(allfoods), possiblefoods)

    println(length(filter(x -> x in safefoods, allfoods)))
    # safefoods = setdiff(allfoods, possiblefoods)
end

main()
