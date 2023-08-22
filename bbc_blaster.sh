#!/bin/bash
for i in $(seq 0 5); do
    ffmpeg -y -i "http://a.files.bbci.co.uk/media/live/manifesto/audio/simulcast/hls/nonuk/sbr_low/ak/bbc_world_service.m3u8" -ar 16000 -ac 1 -c:a pcm_s16le -t 30s /tmp/bbcws0.wav > /dev/null 2> /tmp/radioerr &
    PID=( $PID $! )
    wait
    mv /tmp/bbcws0.wav /tmp/bbcws.wav
    ./main -t 8 -m ./models/ggml-base.en.bin -f /tmp/bbcws.wav --no-timestamps -otxt > /dev/null 2> /tmp/whispererr &
    cat /tmp/bbcws.wav.txt
    echo
done
