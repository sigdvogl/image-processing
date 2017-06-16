#!/usr/bin/env bash

# Target for Logfile
LOGFILE="/Users/vogl/Library/Logs/image_convert.log"

# create Timestamp
TIMESTAMP=`date "+%Y-%m-%d %H:%M:%S"`

# Source and destination folders
SRC="300dpi"
DEST="2000x2000"

CopyFiles() {
    cp ${1}/$i ${2}/$3 2>> $LOGFILE
    echo "[$TIMESTAMP] copied file $3 from $1/ to $2/" >> $LOGFILE

    #syslog -s -k Facility com.apple.console \
    #             Level Error \
    #             Sender MyScript \
    #             Message "script says hello"

}

MoveFiles() {
    mv ${1}/$i ${2}/$3 2>> $LOGFILE
    echo "[$TIMESTAMP] moved file $3 from $1/ to $2/" >> $LOGFILE

    #syslog -s -k Facility com.apple.console \
    #             Level Error \
    #             Sender MyScript \
    #             Message "script says hello"

}

# start logging
echo "[$TIMESTAMP] Start moving images..." >> $LOGFILE

# create folder, if needed
mkdir -p "$DEST"

# read file list and do
cat list.txt | while read i; do

# copy files from source to destination and log
if [ "$1" = "cp" ]
then
    CopyFiles $SRC $DEST $i
else
    MoveFiles $SRC $DEST $i
fi

done