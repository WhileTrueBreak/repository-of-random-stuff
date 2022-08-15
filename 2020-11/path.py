def path(n, m):
    total = 0
    if(n != 1):
        total += path(n-1, m)
    if(m != 1):     
        total += path(n, m-1)
    if(m == 1 or n == 1):
        return 1
    return total
print(path(30, 30))
