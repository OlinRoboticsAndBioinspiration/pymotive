import time
import pymotive.pymotive as pm


def start_cameras(project=None, trackables=None, calibration=None):
    # Make sure all cameras were shutdown properly before starting
    print "Ensuring cameras were properly shut down"
    shutdown_cameras()

    # Start the cameras
    print "Starting up"
    pm.pyTT_Initialize()

    # Wait for the cameras to warm up
    print "Initializing..."
    for i in range(1000):
        pm.pyTT_Update()
        time.sleep(0.01)
    print "Initializing Complete"

    # Check if the project loaded successfully
    if project is not None:
        res = pm.pyTT_LoadProject(project)
        if res != 0:
            print pm.pyTT_GetResultString(res)
            return
        else:
            print "Project file loaded successfully"

    # Check if the calibration loaded successfully
    if calibration is not None:
        res = pm.pyTT_LoadCalibration(calibration)
        if res != 0:
            print pm.pyTT_GetResultString(res)
            return
        else:
            print "Calibration file loaded successfully"

    # Check if the trackables loaded successfully
    if trackables is not None:
        res = pm.pyTT_LoadTrackables(trackables)
        if res != 0:
            print pm.pyTT_GetResultString(res)
            return
        else:
            print "Trackables file loaded successfully"


def print_cameras():
    for i in range(pm.pyTT_CameraCount()):
        print "Camera %d: %s" % (i, pm.pyTT_CameraName(i))


def print_trackables():
    for i in range(pm.pyTT_TrackableCount()):
        print "Trackable %d: %s" % (i, pm.pyTT_TrackableName(i))


def shutdown_cameras():
    pm.pyTT_Shutdown()
    pm.pyTT_FinalCleanup()
    time.sleep(2.5)
    print "Cameras Shut Down"
