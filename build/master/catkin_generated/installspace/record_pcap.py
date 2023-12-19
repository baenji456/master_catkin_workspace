#!/usr/bin/env python3
import rospy
import ouster.pcap
import argparse
from libpcap import pcap
from datetime import datetime
from std_msgs.msg import String
from sensor_msgs.msg import Image
from more_itertools import time_limited
from contextlib import closing
from ouster import client


def callback(data):
    rospy.loginfo(rospy.get_caller_id() + "I heard %s", data.header.frame_id)
    return
        
def capture(n_seconds):

    # In ROS, nodes are uniquely named. If two nodes with the same
    # name are launched, the previous one is kicked off. The
    # anonymous=True flag means that rospy will choose a unique
    # name for our 'listener' node so that multiple listeners can
    # run simultaneously.
    rospy.init_node('capture', anonymous=True)


    with closing(client.Sensor("169.254.130.88", 7502, 7503,
                            buf_size=640)) as source:

        # make a descriptive filename for metadata/pcap files
        time_part = datetime.now().strftime("%Y%m%d_%H%M%S")
        meta = source.metadata
        #fname_base = f"{meta.prod_line}_{meta.sn}_{meta.mode}_{time_part}"
        fname_base = f"/home/benni/catkin_ws/0_Stream_Files/PCAP/ouster_pcap_{time_part}"

        print(f"Saving sensor metadata to: {fname_base}.json")
        source.write_metadata(f"{fname_base}.json")

        print(f"Writing to: {fname_base}.pcap (Ctrl-C to stop early)")
        source_it = time_limited(n_seconds, source)
        n_packets = ouster.pcap.record(source_it, f"{fname_base}.pcap")

        print(f"Captured {n_packets} packets")
        
    # spin() simply keeps python from exiting until this node is stopped
    rospy.spin()

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Parser')
    parser.add_argument('capture_time', type=int,
                    help='an integer for lengths of capture in seconds')
    args = parser.parse_args()
    capture(args.capture_time)