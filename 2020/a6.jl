using LinearAlgebra
using DelimitedFiles
using StatsBase

# not 115, it's too high
# input = split(read("in4.txt", String), "\n\n")
# input = split(read("valid.txt", String), "\n\n")


testin = """
abc

a
b
c

ab
ac

a
a
a
a

b
"""

input = split(read("testin6.txt", String), "\n\n")
sum(length.(filter.(x -> x != '\n', Set.(collect.(input)))))
