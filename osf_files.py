import cv2
from contextlib import closing
from ouster import pcap
from ouster import client
import numpy as np
from scipy.spatial.transform import Rotation as Rot
import open3d as o3d
from ouster import osf
import copy
import pandas as pd

#pcap_path = "/home/benni/Desktop/Daten Master/Ouster/OS2_Campus_Test/OS-2-128-992317000331-2048x10.pcap"
config = "/home/benni/Desktop/Daten Master/Ouster/OS2_Campus_Test/OS-2-128-992317000331-2048x10.json"
ego_motion_path = "/home/benni/Desktop/Daten Master/Ouster/OS2_Campus_Test/campus_test.csv"
save_path = "/home/benni/Desktop/Daten Master/Ouster/OS2_Campus_Test/pcd"
osf_path = "/home/benni/Desktop/Daten Master/Ouster/OS2_Campus_Test/sample.osf"


with open(config, 'r') as f:
    metadata = client.SensorInfo(f.read())
    #source = osf.Scans(osf_path)#pcap.Pcap(pcap_path, metadata)
    load_scan = lambda:  osf.Scans(osf_path)
    j = 0


all_frames = []
with closing(load_scan()) as stream:
    all_poses = []
    for i, scan in enumerate(stream):
        xyzlut = client.XYZLut(metadata)
        xyz = xyzlut(scan)
        xyz = client.destagger(stream.metadata, xyz)
        h, w, c = xyz.shape
        scalar_Id = np.array(range(0, h*w)).astype(np.int32)
        reflectivity_field = scan.field(client.ChanField.REFLECTIVITY)
        reflectivity_img = client.destagger(
            stream.metadata, reflectivity_field)
        range_field = scan.field(client.ChanField.RANGE)
        range_img = client.destagger(stream.metadata, range_field)
        ones_img = np.ones_like(reflectivity_img[..., None])
        color_img = cv2.applyColorMap(
            np.uint8(reflectivity_img), cv2.COLORMAP_JET)
        print("pose", scan.pose[0,...])
        
        cv2.imshow("tmp", color_img)
        # cv2.imshow("spherical",ref_img_col)

        mesh = o3d.geometry.TriangleMesh.create_coordinate_frame()
        mesh_t = copy.deepcopy(mesh).transform(scan.pose[0,...])
        all_poses.append(scan.pose[0,...])
        print(len(all_poses))
        cv2.waitKey(1)