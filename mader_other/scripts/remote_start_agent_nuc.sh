#!/bin/bash

# VEH=$1
# NUM=$2
# QUAD=$VEH$NUM
# SESSION=remote_$QUAD

# if [ -z "$1" ]
#     then
#         echo "No vehicle selected"
#         echo "Example use: ./remote_start.sh SQ 02"
#         exit
#     else
#         echo "Starting vehicle $QUAD"
# fi


echo "----> Starting NUC!"
# NUC stuff

# #Check if the USB is connected
# if ssh nvidia@J$QUAD.local "ls -l /media/nvidia" | grep -q 'jesus_usb'; then
#    echo "Usb detected!"
# else
#     echo "PLEASE CONNECT THE USB!!"
#     exit 1
# fi

# ssh -t nvidia@J$QUAD.local "sudo nvpmodel -m 0 && sleep 1 && sudo ~/jetson_clocks.sh"


ssh -t ubuntu@NHX09.local "sudo ntpdate time.nist.gov"

# tmux new -s session_name
tmux new-session -d -s session_jetson
tmux send-keys 'ssh ubuntu@NHX09.local' C-m
tmux send-keys 'my_date=$(date '+%Y_%m_%d_%H_%M_%S') && (source /home/ubuntu/.bashrc &&    source /opt/ros/melodic/setup.bash &&   source /home/ubuntu/Desktop/ws/devel/setup.bash && 
 roscd mader && git rev-parse HEAD && git diff --color && cd /home/ubuntu/Desktop/bags/ &&
 roslaunch mader hw.launch perfect_prediction:=false) 2>&1 | tee /home/ubuntu/Desktop/bags/mader_${my_date}.txt' C-m #roslaunch mader hw.launch perfect_prediction:=true //start_rs.launch



# tee mader_${my_date}.txt

tmux -2 attach-session -t session_jetson
