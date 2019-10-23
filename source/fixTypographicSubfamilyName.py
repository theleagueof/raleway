#!/usr/bin/env python
# -*- coding: utf-8 -*-
from __future__ import print_function

import unicodedata
import os

from fontTools.ttLib import TTFont



def getName(path):
    f = TTFont(path)
    nametable = f['name']
    name = nametable.getName(17,3,1,0x0409)
    
    return name


def setName(path, new_name):
    f = TTFont(path)
    nametable = f['name']
    nametable.setName(new_name, 17, 3, 1, 0x409)
    os.remove(path)
    f.save(path)



# source, dest
copyDict = {
    'Raleway[wght].ttf': 'Raleway-Medium.ttf',
    'Raleway-Italic[wght].ttf' : 'Raleway-MediumItalic.ttf',
    
    
    }


basePath = '../fonts/ttf'

for destFileAndExt, sourceFileAndExt in copyDict.items():
    
    sourcePath = os.path.join(basePath, sourceFileAndExt)
    destPath = os.path.join(basePath, destFileAndExt)

    sourceName = getName(sourcePath)
    destName = getName(destPath)

    
    if not str(destName) == str(sourceName):
        print ('Name doesnt match:', destFileAndExt, sourceFileAndExt ) 
        setName(destPath, str(sourceName) )
        print ('Name  updated:', getName(destPath))
        
    if str(destName) == str(sourceName):
        print ('Name already matches:', destFileAndExt, sourceFileAndExt ) 
       



print ('done checking TYPOGRAPHIC_SUBFAMILY_NAME, (aka f.info.openTypeNamePreferredSubfamilyName)')