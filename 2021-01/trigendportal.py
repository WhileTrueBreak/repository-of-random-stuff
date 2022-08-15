import math
t1 = float(input("angle 1: "))*math.pi/180
x1 = float(input("z1: "))
y1 = float(input("x1: "))
m1 = -math.tan(t1)
c1 = -m1*x1+y1
#print(c1)
#print(m1)
t2 = float(input("angle 2: "))*math.pi/180
x2 = float(input("z2: "))
y2 = float(input("x2: "))
m2 = -math.tan(t2)
c2 = -m2*x2+y2
x = (c2-c1)/(m1-m2)
y = m1*x+c1
print("("+str(y)+","+str(x)+")")
