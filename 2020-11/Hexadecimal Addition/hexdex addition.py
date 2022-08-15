while True:
    x = int(input("x: "))
    y = int(input("y: "))

    xp = 15-x
    o = 0
    if(y-1)>=xp:
        print("carry: 1")
        yp = 15-y
        o = 14-xp-yp
    else:
        op = xp-y
        o = 15-op
    print("output: "+str(o))
