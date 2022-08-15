import random as r
n = 1000
digits = [6]
digits+=[int(char) for char in input("Digits: ")]
##generate random 11numbers
def genDigit(digits):
    nDigits = digits.copy()
    while(len(nDigits)<11):
        nDigits.append(r.randint(0,9))
    return nDigits
    #return [r.randint(0,9) for i in range(11)]
##make sure no dupes
ubcs = []
try:
    file2=open("barcodes_all.txt","r")
    ubcs = file2.readlines()
    ubcs = [ubc[0:-1] for ubc in ubcs]
    file2.close()
except:
    ubcs = []
bcs = []
for i in range(n):
    bc = []
    while(True):
        bc = genDigit(digits)
        if(bcs.count(bc)==0 and ubcs.count("".join([str(i) for i in bc]))==0):break
    bcs.append(bc)
#add final digit and write to file
    
file1=open("barcodes_new.txt","w+")
file2=open("barcodes_all.txt","a")
for bc in bcs:
    n=sum([bc[i]*3 if i%2==0 else bc[i]for i in range(len(bc))])%10
    if(n!=0):n=10-n
    bc.append(n)
    barcodeStr = "".join([str(i) for i in bc])
    print(barcodeStr)
    file1.write(barcodeStr+"\n")
    file2.write(barcodeStr+"\n")
file1.close()
file2.close()
