#!/bin/bash
set -e # stop on first error

rm -f /results/{gource.ppm,gource.mp4}

screen -dmS recording xvfb-run -a -s "-screen 0 1280x720x24" gource -1280x720 -r 30 --title "$TITLE" --user-image-dir /avatars/ --highlight-all-users -s 0.5 -o /results/gource.ppm

# This hack is needed because gource process doesn't stop
sleep 5
filesize=$(stat -c '%s' /results/gource.ppm)
while [[ "$filesize" -eq "0" || $filesize -lt $(stat -c '%s' /results/gource.ppm) ]] ;
do
	sleep 20
	filesize=$(stat -c '%s' /results/gource.ppm)
    echo 'Polling the size. Current size is' $filesize
done
echo 'Force stopping recording because file size is not growing'
screen -S recording -X quit

xvfb-run -a -s "-screen 0 1280x720x24" ffmpeg -y -r 30 -f image2pipe -loglevel info -vcodec ppm -i /results/gource.ppm -vcodec libx264 -preset medium -pix_fmt yuv420p -crf 1 -threads 0 -bf 0 /results/gource.mp4
rm -f /results/gource.ppm