import sys
import os
import argparse
import shutil
import math
import time

import cv2

def imgToText(img, rows, cols):
    text = ""
    gscale = '@%#*+=-:.  '
    img = cv2.resize(img, (cols, rows), interpolation = cv2.INTER_AREA)
    for i in range(rows):
        string = ""
        for j in range(cols):
            value = img[i][j]/255
            index = math.floor((1-value)*(len(gscale)-1))
            string += gscale[index]
        text+=string+"\n"
    return text

def readFrames(pathIn, rows, cols, fps):
    if(os.path.isdir("frames")):
        shutil.rmtree("frames")
    os.makedirs("frames")
    frame = 0
    vidcap = cv2.VideoCapture(pathIn)
    success,image = vidcap.read()
    while True:
        vidcap.set(cv2.CAP_PROP_POS_MSEC,(frame*(1000/fps)))
        success,image = vidcap.read()
        if(not success):break
        gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
        print("Converting frame: "+str(frame))
        text = imgToText(gray, rows, cols)
        file = open("frames/frame"+str(frame)+".txt", "x")
        file.write(text)
        file.close()
        frame += 1

def playFrame(fps):
    cFrame = 0
    frame = []
    frameH = len(open("frames/frame0.txt",'r').readlines())
    while True:
        if(not os.path.isfile("frames/frame"+str(cFrame)+".txt")):break
        temp = open("frames/frame"+str(cFrame)+".txt",'r').readlines()
        frame.append("".join(temp))
        print("loading frame: "+str(cFrame))
        cFrame += 1
    
    os.system("cls")
    input("[play]")
    cFrame = 0
    timeperTick = 1000000000/fps;
    delta = 0
    lastTime = time.process_time_ns()
    start_tick_length = time.process_time_ns() 
    
    tst = time.process_time()
    while True:
        now = time.process_time_ns()
        delta += (now - lastTime)/timeperTick
        lastTime = now
        if(delta >= 1):
            if(cFrame>=len(frame)):break
            print((("\n"*frameH)+frame[cFrame])[:-1],end="")
            cFrame+=1
            delta-=1
            if(delta > 1):
                delta-=1
        start_tick_length = time.process_time_ns()
    tet = time.process_time()
    print("Time elapsed: ",tet-tst) 
    
if __name__=="__main__":
    a = argparse.ArgumentParser()
    a.add_argument("--path")
    args = a.parse_args()
    readFrames(args.path, 30, 100, 30)
    playFrame(30)
