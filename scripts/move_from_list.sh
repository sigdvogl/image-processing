#!/usr/bin/env bash

# Parameters for function
# cp: copy files
# mv: move files
# konf: choose konf folders
# spw: choose spw folders

if [ "$1" = "konf" ]; then
    ITEMTYPE="Konf_"

elif [ "$1" = "spw" ]; then
    ITEMTYPE="Spw_"

else
    echo "wrong parameter"
    break
fi

# Target for Logfile
LOGFILE="image_convert.log"
LOGFILEPATH="/Users/vogl/Library/Logs/Image_Convert/${LOGFILE}"

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

       cp ${SOURCE}/$i ${TARGET}/$i 2>> $LOGFILEPATH
       echo "[$TIMESTAMP] copied file $i from $SOURCE/ to $TARGET/"
       echo "[$TIMESTAMP] copied file $i from $SOURCE/ to $TARGET/" >> $LOGFILEPATH

    done
    }

# start logging
echo "[$TIMESTAMP] Start moving images..." >> $LOGFILEPATH


# read file list and do
cat list.txt | while read i; do
    CopyFiles
    done

# Copy logfile to target folder
echo "Copy logfile..."
cp $LOGFILEPATH "$BASEDEST/$LOGFILE"