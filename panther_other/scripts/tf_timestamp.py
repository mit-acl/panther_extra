#!/usr/bin/env python

import rospy
import tf

vicon_name = "NX04_b"
republish_name = "NX04"


if __name__ == "__main__":
    rospy.init_node("tf_republisher")

    listener = tf.TransformListener()
    broadcaster = tf.TransformBroadcaster()

    rate = rospy.Rate(150.0)
    while not rospy.is_shutdown():
        # Try to get transfrom from vicon
        try:
            (trans,rot) = listener.lookupTransform("world", vicon_name, rospy.Time(0))
        except (tf.LookupException, tf.ConnectivityException, tf.ExtrapolationException):
            continue
        
        # Republish transform
        broadcaster.sendTransform(trans, rot, rospy.Time.now(), republish_name, "world")

        rate.sleep()
