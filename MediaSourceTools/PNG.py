# coding=utf-8
"""
IMG内部PNG图片操作类模块
"""
from NkpImgTools import *
from PIL import Image


class Pic:
    def __init__(self, pngAnaContent):
        self.colorSystem = pngAnaContent[0]
        self.width = pngAnaContent[2]
        self.height = pngAnaContent[3]
        self.content = pngAnaContent[-1]
        self.img = Image.new('RGBA', (self.width, self.height))
        self.draw()

    def put_pixels(self, pixels, imageObj):
        for i in range(self.width):
            for j in range(self.height):
                pixel_index = j * self.width + i
                imageObj.putpixel((i, j), pixels[pixel_index])

    def draw(self):
        # print(self.width * self.height)
        if self.colorSystem == 'ARGB8888':
            self.put_pixels(argb8888(self.content), self.img)
        elif self.colorSystem == 'ARGB4444':
            self.put_pixels(argb4444(self.content), self.img)
        elif self.colorSystem == 'ARGB1555':
            self.put_pixels(argb1555(self.content), self.img)
        elif self.colorSystem == 'ABGR8888':
            self.put_pixels(self.content, self.img)

    def show(self):
        self.img.show()

    def save(self, path):
        self.img.save(path)


if __name__ == '__main__':
    pass
