function main()
    v = 1
    # subjnum = 7
    # subjnum = 17807724
    subjnum = 4542595
    # subjnum = 2959251

    # loopsize = 100000000
    # loopsize = 8
    # loopsize = 11
    loopsize = 7731677
    # loopsize = 16473833

    for i in 1:loopsize
        v = v * subjnum
        v = v % 20201227

        # if v in [2959251, 4542595, 17807724]
        #     println(v)
        #     println(i)
        #     println()
        # end
    end
    println(v)


end

main()



# 2959251
# 4542595

# subjnum = 2959251
# loopsize = 7731677
#
# subjnum = 4542595
# loopsize = 16473833
