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

# create Timestamp
TIMESTAMP=`date "+%Y-%m-%d %H:%M:%S"`
FILESTAMP=`date "+%Y-%m-%d_%H-%M-%S"`

# Target for Logfile
LOGFILE="${FILESTAMP}-image_convert.log"
touch /Users/vogl/Library/Logs/Image_Convert/${LOGFILE}
LOGFILEPATH="/Users/vogl/Library/Logs/Image_Convert/${LOGFILE}"


# Basepath
BASESRC="../images"

# Destination for image master
BASEDEST="/Volumes/Bilddaten/master"

# Destination for Navision images
#BASEDEST="/Volumes/Bilddaten/Konf"

# declare folders with images
# all master images
declare -a arrFolders=("250x250" "800x600" "2000x2000" "300dpi")
# Navision only
#declare -a arrFolders=("250x250")

# shell functions
CopyFiles() {

    ## now loop through the above array
    echo "[$TIMESTAMP] copied file $i from..." >> $LOGFILEPATH
    for fold in "${arrFolders[@]}"
    do

        SOURCE=${BASESRC}/${fold}

        # Target for master image folders
        TARGET=${BASEDEST}/${ITEMTYPE}${fold}

        # Target for Navision image folder
#         TARGET=${BASEDEST}

        mkdir -p "$TARGET"

       cp ${SOURCE}/$i ${TARGET}/$i 2>> $LOGFILEPATH
       echo "[$TIMESTAMP] copied file $i from $SOURCE/ to $TARGET/"
       echo "[$TIMESTAMP] $SOURCE/ to $TARGET/" >> $LOGFILEPATH

    done
    }

# start logging
echo "[$TIMESTAMP] Start moving images..." >> $LOGFILEPATH

# read file list and do
cat list.txt | while read i; do
    CopyFiles
    done

# Copy logfile to target folder
echo "... done" >> $LOGFILEPATH
echo "Copy logfile..."
cp $LOGFILEPATH "$BASEDEST/logs/$LOGFILE"