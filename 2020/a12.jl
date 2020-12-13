input = split(read("in12.txt", String), "\n")[1:end-1]

# ns = parse.(Int, String.(replace.(collect.(input), 'F'=>'0','B'=>'1','L'=>'0','R'=>'1'))[1:end-1], base=2)

#absolute = filter(x -> x[1] in ['N' 'E' 'S' 'W'], input)

relative = filter(x -> occursin("R", x) || occursin("L", x) || occursin("F", x), input)

absolutex = sum(parse.(Int, String.(replace.(collect.(filter(x -> x[1] in ['E' 'W'], input)), 'E'=>'+','W'=>'-'))))
absolutey = sum(parse.(Int, String.(replace.(collect.(filter(x -> x[1] in ['N' 'S'], input)), 'N'=>'+','S'=>'-'))))

abspos = (absolutex, absolutey)


function degToDirection(deg)
  convert = Dict(
      0 => (1,0),
      90 => (0,1),
      180 => (-1,0),
      270 => (0,-1),
      -90 => (0,-1),
      -180 => (-1,0),
      -270 => (0,1))

  return convert[deg % 360]
end

input = split(read("testin12.txt", String), "\n")
input = split(read("in12.txt", String), "\n")[1:end-1]

function run(input)
    pos = (0,0)
    angle = 0

    for step in input
        # println(pos)
        # println(step)
        m = match(r"(\w)(\d+)", step)
        dir = m[1]
        mag = parse(Int, m[2])

        if dir == "F"
            pos = pos .+ mag .* degToDirection(angle)
        end

        if dir == "L"
            angle += mag
        end
        if dir == "R"
            angle -= mag
        end

        if dir == "N"
            pos = pos .+ (mag .* (0,1))
        end
        if dir == "E"
            pos = pos .+ (mag .* (1,0))
        end
        if dir == "S"
            pos = pos .+ (mag .* (0,-1))
        end
        if dir == "W"
            pos = pos .+ (mag .* (-1,0))
        end


    end
    println(abs(pos[1]) + abs(pos[2]))
end
