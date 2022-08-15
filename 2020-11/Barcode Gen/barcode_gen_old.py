import random as r

n = int(input("Number of Barcodes: "))
##generate random 11numbers
def genDigit():
    return [r.randint(0,9) for i in range(11)]


##make sure no dupes
bcs = []
for i in range(n):
    bc = []
    while(True):
        bc = genDigit()
        if(bcs.count(bc) == 0):break
    bcs.append(bc)
#add final digit and write to file
file=open("Barcodes.txt","w+")
for bc in bcs:
    n=sum([bc[i]*3 if i%2==0 else bc[i]for i in range(len(bc))])%10
    if(n!=0):n=10-n
    bc.append(n)
    barcodeStr = "".join([str(i) for i in bc])
    print(barcodeStr)
    file.write(barcodeStr+"\n")
file.close()
