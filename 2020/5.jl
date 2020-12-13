input = input = split(read("in5.txt", String), "\n")
ns = parse.(Int, String.(replace.(collect.(input), 'F'=>'0','B'=>'1','L'=>'0','R'=>'1'))[1:end-1], base=2)
setdiff(Set(32:848), Set(ns))

# replace.(collect.(input), 'F' => '1', 'B' => '0', 'L' => '1', 'R' => '0')

# a = [1:5;]  # => 5-element Array{Int64,1}: [1,2,3,4,5]k
