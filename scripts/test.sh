#!/usr/bin/env bash

# Target for Logfile
LOGFILE="/Users/vogl/Library/Logs/image_convert.log"

# create Timestamp
TIMESTAMP=`date "+%Y-%m-%d %H:%M:%S"`

# Source and destination folders
BASEPATH="../images"
SRC="${BASEPATH}/300dpi"
DEST="${BASEPATH}/2000x2000"

CopyFiles() {
    cp ${1}/$i ${2}/$3 2>> $LOGFILE
    echo "[$TIMESTAMP] copied file $3 from $1/ to $2/" >> $LOGFILE
    }

MoveFiles() {
    mv ${1}/$i ${2}/$3 2>> $LOGFILE
    echo "[$TIMESTAMP] moved file $3 from $1/ to $2/" >> $LOGFILE
    }

# start logging
echo "[$TIMESTAMP] Start moving images..." >> $LOGFILE

# create folder, if needed
mkdir -p "$DEST"

# read file list and do
cat list.txt | while read i; do

# copy files from src to dest and log
if [ "$1" = "cp" ]
then
    CopyFiles $SRC $DEST $i

# move files from src to dest and log
else
    MoveFiles $SRC $DEST $i
fi

done