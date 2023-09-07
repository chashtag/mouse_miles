#!/usr/bin/env python3
import os
import struct
import math
import threading
import time

c,cm = 0,0
offset_x = 1.0
offset_y = 1.0
dpi = 244


def p_to_miles(x):
    return round((x/dpi)*1.6440444056709E-7,10)


def calc_distance(x,y):
    x *= offset_x
    y *= offset_y 
    return math.sqrt((abs(x)**2+abs(y)**2))


def bg_thread():
    while True:
        time.sleep(1)
        with open('/dev/mouse_miles','w+') as w:
            w.write(f'{cm:.10f}\n')


if __name__ == '__main__':
    if os.getuid():
        print('Must be ran as root!')
        exit()

    t1 = threading.Thread(target=bg_thread)
    t1.setDaemon = True
    t1.start()


    with open("/dev/input/mice", mode="rb") as f:
        while True:
            button, x, y = struct.unpack('bbb', f.read(3))
            c += calc_distance(x,y)
            cm = p_to_miles(c)
