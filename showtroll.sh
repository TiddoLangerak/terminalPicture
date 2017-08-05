#!/bin/bash

WINDOW_ID=$(./getscreen.sh)
if [ $? -ne 0 ]; then
	echo "No window found";
	exit 1;
fi;

eval $(xdotool getwindowgeometry -shell $WINDOW_ID)
COLS=$(tput cols)
ROWS=$(tput lines)
ROW_HEIGHT=$(($HEIGHT / $ROWS))
COL_WIDTH=$(($WIDTH / $COLS))

LEFT_MARGIN=6
BOTTOM_MARGIN=12


IMAGE=~/Pictures/troll.png
IMAGE_ROWS=5
IMAGE_HEIGHT=$(($IMAGE_ROWS * $ROW_HEIGHT))
IMAGE_WIDTH=20

TARGET_ROW=$(($ROWS-$IMAGE_ROWS))
TARGET_COL=0
ROW_OFFSET_BOTTOM=$(($ROWS - $TARGET_ROW))

TARGET_X=$(($LEFT_MARGIN + $X + ($COL_WIDTH * $TARGET_COL)))
# We calculate the Y from the bottom, since terminals usually work from bottom up 
TARGET_Y=$(($Y + $HEIGHT - ($ROW_OFFSET_BOTTOM * $ROW_HEIGHT) - $BOTTOM_MARGIN))
POS="${IMAGE_WIDTH}x${IMAGE_HEIGHT}+${TARGET_X}+${TARGET_Y}"
feh -x -g $POS --title __force_float__ ~/Pictures/troll.png &

for n in $(seq $(($IMAGE_ROWS - 1))); do
	echo "_"
done

wait

