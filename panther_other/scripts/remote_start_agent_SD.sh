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


VEH=HX
NUM=09
QUAD=$VEH$NUM
SESSION=remote_$QUAD


# check that an ssh connection can even be made
ssh -q root@$QUAD.local exit
if [ $? -ne 0 ]; then
    echo -e "\033[0;31mNo connection to $QUAD\033[0m"
    exit
fi

ssh -t root@$QUAD.local "ntpdate time.nist.gov"


cmd="new-session -d -s $SESSION"
cmd="$cmd ; split-window -h"
cmd="$cmd ; split-window -v"
cmd="$cmd ; select-pane -t $SESSION:0.0"
cmd="$cmd ; split-window -v"
cmd="$cmd ; select-pane -t $SESSION:0.2"
cmd="$cmd ; split-window -v"
cmd="$cmd ; select-pane -t $SESSION:0.1"
cmd="$cmd ; split-window -v"
cmd="$cmd ; select-pane -t $SESSION:0.5"
cmd="$cmd ; split-window -v"

tmux -2 $cmd

for _pane in $(tmux list-pane -F '#P'); do
    tmux send-keys -t $SESSION:0.${_pane} "ssh root@$QUAD.local" C-m
    sleep 1
done

tmux send-keys -t $SESSION:0.4 "imu_app -s 2" C-m
tmux send-keys -t $SESSION:0.0 "roslaunch outer_loop cntrl.launch" C-m
tmux send-keys -t $SESSION:0.3 "roslaunch snap esc.launch" C-m


#IF YOU WANNA USE VIO
tmux send-keys -t $SESSION:0.5 "roslaunch snap snap.launch extpose:=pose_selector/vislam_registered" C-m
tmux send-keys -t $SESSION:0.1 "roslaunch vislam_utils pose_selector.launch shutdown_mocap:=true" C-m
tmux send-keys -t $SESSION:0.2 "roslaunch vislam vislam.launch initLnDepth:=-2.617" C-m # on stand
tmux send-keys -t $SESSION:0.6 "my_date=$(date '+%Y_%m_%d_%H_%M_%S') && (sleep 3 && rosservice call /HX09/pose_selector/sample '{}' && sleep 10 && rosservice call /HX09/pose_selector/select 'data: true' && cd /media/sdcard/bags && rosbag record -o sd /HX09/state /HX09/log /HX09/image_raw/compressed /HX09/vio/map_points /HX09/motors /HX09/log /HX09/state) | tee /media/sdcard/bags/sd_${my_date}.txt" C-m
#Then, you should either switch off vicon, uncheck this drone in the vicon software, or change its name in vicon to HX09gt (ground truth or something like that)

#IF YOU WANNA USE MOCAP (VICON)
# tmux send-keys -t $SESSION:0.5 "roslaunch snap snap.launch" C-m


tmux select-pane -t $SESSION:0.1
tmux -2 attach-session -t $SESSION








#tmux send-keys -t $SESSION:0.0 "roslaunch aclswarm snapstack_cntrl.launch" C-m
# tmux send-keys -t $SESSION:0.1 "roslaunch panther_other obstacle.launch quad:=$VEH$NUM" C-m
#tmux send-keys -t $SESSION:0.1 "roslaunch aclswarm start.launch veh:=$VEH$NUM use_assignment:=true"
#tmux send-keys -t $SESSION:0.6 "rosrun aclswarm bagrecord.sh -o $VEH$NUM"