from PIL import Image
import sys, time, threading
import numpy as np

path_save = "../Image/image.txt"

def main():
    path = input("Enter the path of the image :\n")
    
    global img
    img = Image.open(path)
    if checkSize():
        if checkMode():
            showImage() 
            callAnimation()

def checkSize():
    global width, height
    width, height = img.size
    if width >= 640 and height >= 480:
        print('Size Image: ', img.size)
        return True
    else:
        print('\x1b[0;31;49m' + 'Error, Image size '+ str(width)+'x'+str(height)+ 'less than 640x480.' + '\x1b[0m')
        return False

def checkMode():   
    global img
    if img.mode == 'L':
        return True
    else:        
        print('\x1b[0;33;49m' +  'Warning, Image RGB !' + '\x1b[0m')
        reply = str(input('Do you want to convert the image to grayscale? (Y/n): ')).lower().strip()
        if reply=='':
            img = img.convert('L')
            return True
        else:
            if reply[0] == 'y':
                img = img.convert('L')
                return True
            else:
                return False

def showImage():
    reply = str(input('Would you like to see the image? (Y/n): ')).lower().strip()
    if reply=='' or reply=='y':
        baseheight = 480
        hpercent = (baseheight / float(img.size[1]))
        wsize = int((float(img.size[0]) * float(hpercent)))
        i = img
        i.resize((wsize, baseheight), Image.ANTIALIAS).show()
    
def save():
    iar = np.asarray(img)
    global width
    b = ((width + 3) * '000')
    b = b + '000000'.join(''.join('%03d' %x for x in y) for y in iar)    
    b = b + ((width + 3) * '000')
    f= open(path_save,"w+")
    f.write(b)

def loadingAnimation(process) :
    while process.isAlive() :
        chars = "/—\\|" 
        for char in chars:
            sys.stdout.write('\x1b[0;32;49m' + '\r'+'> Processing image '+char + '\x1b[0m')
            time.sleep(.1)
            sys.stdout.flush()
    callASM()

def callAnimation():
    loading_process = threading.Thread(target=save)
    loading_process.start()
    loadingAnimation(loading_process)
    loading_process.join()

def callASM():
    print('', end="\r")
    print('\x1b[0;32;49m> Successful processing. \x1b[0m')

main()