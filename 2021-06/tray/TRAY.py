import sys
import os
import argparse
import shutil
import math
import time

import cv2

import PySimpleGUIQt as sg
from multiprocessing import Process
from multiprocessing import Pool

import random


trays = {}

dir(sg)

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
        img = cv2.resize(gray, (dim, dim), interpolation = cv2.INTER_AREA)
        file = open("frames/frame"+str(frame)+".txt", "x")
        for i in img:
            string = ""
            for j in i:
                string += str(j)
            file.write(string)
        file.close()
        frame += 1

def update(tray, White):
    if(White == True):
        tray.Update(filename="w.jpg")
    else:
        tray.Update(filename="b.jpg")
    tray.UnHide()
        
icount = 16
dim = 12

for i in range(dim*dim-icount):
    index = i+icount
    x = index%dim
    y = index//dim
    key = str(x)+","+str(y)
    trays[key] = sg.SystemTray(str(x)+","+str(y), filename='b.jpg')

i = 0

if __name__ == '__main__':
    a = argparse.ArgumentParser()
    a.add_argument("--path")
    a.add_argument("--use")
    args = a.parse_args()
    #readFrames()
    while True:
        print("loop")
        print(i)
        for key in trays.keys():
            tray = trays[key]
            x = int(key.split(",")[0])
            update(tray, x%dim==i%dim)
        i+=1;
