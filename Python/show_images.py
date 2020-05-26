from PIL import Image
import sys
import time
import threading
import numpy as np


def main():
    global width
    width = int(input("Width : "))
    global height
    height = int(input("Height : "))
    callAnimation()


def while_():
    global width
    global height
    i_width = 0
    i_height = 0

    matrix = np.full((height, width), 0)

    """" ---------------------- SHARPENING ---------------------- """
    with open('../FilteredImages/ImageSharperning.txt', 'r') as file:
        pixels = file.read()

    while i_height < height:
        while i_width < width:
            value_pixel = int(pixels[0:4]) - 4000
            if value_pixel >= 255:
                matrix[i_height][i_width] = 255
            elif value_pixel <= 0:
                matrix[i_height][i_width] = 0
            else:
                matrix[i_height][i_width] = value_pixel
            pixels = pixels[4:]
            i_width = i_width + 1
        i_width = 0
        i_height = i_height + 1
    image = Image.fromarray(matrix.astype(np.uint8), 'L')

    global i_1
    i_1 = image
    i_1.resize((width, height)).save("../Results/sharpening.png")
    


    """ ---------------------- OVER_SHARPENING ---------------------- """
    i_width = 0
    i_height = 0

    matrix = np.full((height, width), 0)
    with open('../FilteredImages/ImageOverSharperning.txt', 'r') as file:
        pixels = file.read()

    while i_height < height:
        while i_width < width:
            value_pixel = int(pixels[0:4]) - 4000
            if value_pixel >= 255:
                matrix[i_height][i_width] = 255
            elif value_pixel <= 0:
                matrix[i_height][i_width] = 0
            else:
                matrix[i_height][i_width] = value_pixel
            pixels = pixels[4:]
            i_width = i_width + 1
        i_width = 0
        i_height = i_height + 1
    image = Image.fromarray(matrix.astype(np.uint8), 'L')

    global i_2
    i_2 = image
    i_2.resize((width, height)).save("../Results/over_sharpening.png")
    



def loadingAnimation(process):
    while process.isAlive():
        chars = "/—\\|"
        for char in chars:
            sys.stdout.write('\x1b[0;32;49m' + '\r' +
                             '> Analyzing image '+char + '\x1b[0m')
            time.sleep(.1)
            sys.stdout.flush()
    callASM()


def callAnimation():
    loading_process = threading.Thread(target=while_)
    loading_process.start()
    loadingAnimation(loading_process)
    loading_process.join()

# ARM


def callASM():
    print('', end="\r")
    print('\x1b[0;32;49m> Successful processing. \x1b[0m')

    reply = str(input('\nWould you like to see the images? (Y/n): ')).lower().strip()

    if reply=='' or reply=='y':
        baseheight = 480
        global i_1
        global i_2

        hpercent = (baseheight / float(i_1.size[1]))
        wsize = int((float(i_1.size[0]) * float(hpercent)))

        i_1.resize((wsize, baseheight), Image.ANTIALIAS).show()

        i_2.resize((wsize, baseheight), Image.ANTIALIAS).show()



main()
