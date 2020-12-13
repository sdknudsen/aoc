using LinearAlgebra
using DelimitedFiles
using StatsBase

input = split(read("testin6.txt", String), "\n\n")
sum(length.(filter.(x -> x != '\n', Set.(collect.(input)))))
