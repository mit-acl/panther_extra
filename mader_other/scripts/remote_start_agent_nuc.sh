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
tmux send-keys 'source /home/ubuntu/.bashrc &&    source /opt/ros/melodic/setup.bash &&   source /home/ubuntu/Desktop/ws/devel/setup.bash &&   roslaunch mader_other start_rs.launch' C-m

tmux -2 attach-session -t session_jetson
