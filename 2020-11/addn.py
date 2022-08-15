def addN(n):
    if(n==1):
        return 1
    else:
        return n+addN(n-1)

print(addN(40))


