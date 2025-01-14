#!/bin/bash

#----------
# Regenerates the site based on some master content.
#----------


rootDir="$( dirname -- "$( realpath "$0" )" )"

regenerateIcon () {
    iconDir="$1"
    rm -f "${iconDir}/64x64.png" "${iconDir}/32x32.png" "${iconDir}/favicon.ico"
    convert "${iconDir}/128x128.png" -resize 64x64 "${iconDir}/64x64.png"
    convert "${iconDir}/128x128.png" -resize 32x32 "${iconDir}/32x32.png"
    convert "${iconDir}/128x128.png" "${iconDir}/64x64.png" "${iconDir}/32x32.png" "${iconDir}/favicon.ico"
} 

regenerateIcon "${rootDir}/icon"
regenerateIcon "${rootDir}/holodb/icon"

find "${rootDir}" -type f -name '*.source.css' | while IFS='' read sourceFile; do
    targetFile="$( echo "${sourceFile}" | sed -E 's/.source.css$/.css/' )"
    echo "${sourceFile} --> ${targetFile}"
done
