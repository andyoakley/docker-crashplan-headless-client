#!/bin/bash

PORT=`cut -f1 -d, /var/lib/crashplan/.ui_info`

ssh -M -S headless-ctrl -fnNT -L $PORT:localhost:$PORT $HEADLESS
ssh -S headless-ctrl -O check $HEADLESS

CrashPlanDesktop

# wait until the app has finished
while killall -0 java
do
    sleep 1
done


ssh -S headless-ctrl -O exit $HEADLESS
