[To add to the remote_start_agent.launch]


#Check if the USB is connected
if ls /media/nvidia | grep -q 'jesus_usb'; then
   echo "Usb detected!"
else
	echo "PLEASE CONNECT THE USB!!"
	exit 1
fi


ssh nvidia@JSQ04 sudo nvpmodel -m 0
sleep(1)
ssh nvidia@JSQ04 sudo ~/jetson_clocks.sh


#Try https://github.com/IntelRealSense/realsense-ros/issues/347#issuecomment-447648813-permalink:~:text=The%20following%20command%20will%20publish%20a,roslaunch%20realsense2_camera%20rs_camera.launch%20filters%3A%3Dpointcloud%20pointcloud_texture_stream%3A%3DRS2_STREAM_ANY%20enable_color%3A%3Dfalse

#Make sure I don't have 129600 points in the point cloud
#Use this (clip distance): https://github.com/IntelRealSense/realsense-ros/blob/c43485b88e29571fed4d65f5c392e2fab320c778/README.md#user-content-launch-parameters:~:text=clip_distance%3A%20remove%20from%20the%20depth%20image%20all%20values%20above%20a%20given%20value%20(meters).%20Disable