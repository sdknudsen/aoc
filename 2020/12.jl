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

function rotateWP(deg, wp)
  convert = Dict(
      0 =>    [1 0; 0 1],
      90 =>   [0 -1; 1 0],
      180 =>  [-1 0; 0 -1],
      270 =>  [0 1; -1 0],
      -90 =>  [0 1; -1 0],
      -180 => [-1 0; 0 -1],
      -270 => [0 -1; 1 0])

  return Tuple(convert[deg % 360] *  wp)
end

input = split(read("testin12.txt", String), "\n")
input = split(read("in12.txt", String), "\n")[1:end-1]

function run(input)
    wp = (10,1)
    pos = (0,0)
    # angle = 0

    for step in input
        m = match(r"(\w)(\d+)", step)
        dir = m[1]
        mag = parse(Int, m[2])

        if dir == "F"
            pos = pos .+ (mag .* wp)
        end

        if dir == "L"
            # angle += mag
            wp = rotateWP(mag, collect(wp))
        end
        if dir == "R"
            wp = rotateWP(-1 * mag, collect(wp))
            # angle -= mag
        end

        if dir == "N"
            wp = wp .+ (mag .* (0,1))
        end
        if dir == "E"
            wp = wp .+ (mag .* (1,0))
        end
        if dir == "S"
            wp = wp .+ (mag .* (0,-1))
        end
        if dir == "W"
            wp = wp .+ (mag .* (-1,0))
        end

    end
    println(abs(pos[1]) + abs(pos[2]))
end
