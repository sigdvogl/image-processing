#!/usr/bin/env bash

# Parameters for function
# cp: copy files
# mv: move files
# konf: choose konf folders
# spw: choose spw folders

if [ "$2" = "konf" ]; then
    ITEMTYPE="Konf_"

elif [ "$2" = "spw" ]; then
    ITEMTYPE="Spw_"

else
    echo "wrong parameter"
    break
fi

# Target for Logfile
LOGFILE="/Users/vogl/Library/Logs/Image_Convert/image_convert.log"

# create Timestamp
TIMESTAMP=`date "+%Y-%m-%d %H:%M:%S"`

# Basepath
BASESRC="../images"
#BASEDEST="/Volumes/Bilddaten/master"
BASEDEST="../images/target"

# declare folders with images
declare -a arrFolders=("250x250" "2000x2000")

# shell functions
CopyFiles() {

    ## now loop through the above array
    for fold in "${arrFolders[@]}"
    do

        SOURCE=${BASESRC}/${fold}
        TARGET=${BASEDEST}/${ITEMTYPE}${fold}

        mkdir -p "$TARGET"

       cp ${SOURCE}/$i ${TARGET}/$i 2>> $LOGFILE
       echo "[$TIMESTAMP] copied file $i from $SOURCE/ to $TARGET/" >> $LOGFILE

    done
    }

# start logging
echo "[$TIMESTAMP] Start moving images..." >> $LOGFILE


# read file list and do
cat list.txt | while read i; do

# copy files from src to dest and log
if [ "$1" = "cp" ]
then
    CopyFiles

# move files from src to dest and log
else
    MoveFiles
fi

done