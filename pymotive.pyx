"""
 * Copyright (c) 2012-2013, Franklin W. Olin College of Engineering
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * - Redistributions of source code must retain the above copyright notice,
 *   this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright notice,
 *   this list of conditions and the following disclaimer in the documentation
 *   and/or other materials provided with the distribution.
 * - Neither the name of Franklin W. Olin College of Engineering nor the names
 *   of its contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 *
 *
 * Cython wrapper of Motive API
 *
 * by Asa Eckert-Erdheim
 *
 * v. 0.01
 *
 * Revisions:
 *  Asa E-E     2012-08-10      Code is fully functional.  Runs slow.
 *  AMH         2013-06-21      Revised code to work with Motive 
 """

from libcpp cimport bool
from libcpp cimport float
import numpy as np
cimport numpy as np
import cython
import time

cdef extern from 'C:\Program Files\OptiTrack\Motive\inc\NPTrackingTools.h':

#~  RIGID BODY STARTUP/SHUTDOWN ========================================

    int TT_Initialize()
    int TT_Shutdown()
    int TT_FinalCleanup()
    
#~  RIGID BODY INTERFACE ===============================================

    int TT_LoadProject(char* name)
    int TT_LoadCalibration(char* name)
    int TT_LoadTrackables(char* name)
    int TT_Update()
    int TT_UpdateSingleFrame()
    
#~  FRAME ==============================================================

    int TT_FrameMarkerCount()
    float TT_FrameMarkerX(int index)
    float TT_FrameMarkerY(int index)
    float TT_FrameMarkerZ(int index)
    int TT_FrameMarkerLabel(int index)
    double TT_FrameTimeStamp()
    
#~  TRACKABLES CONTROL =================================================

    bool TT_IsTrackableTracked(int index)
    void TT_TrackableLocation(int RigidIndex,float *x,float *y,float *z,
        float*qx,float *qy,float *qz,float *qw,float *yaw,float *pitch, 
        float *roll)
 
    int TT_TrackableCount()
    
    int TT_TrackableID(int index)
    void TT_SetTrackableID(int index, int ID)
    char* TT_TrackableName(int index)
    
    bool TT_TrackableEnabled(int index)
    
    int TT_TrackableMarkerCount(int index)
    void TT_TrackableMarker(int RigidIndex, int MarkerIndex, float *x_m,
        float *y_m, float *z_m)
    void TT_TrackablePointCloudMarker(int RigidIndex, int MarkerIndex,
        bool &Tracked, float &x_pc, float &y_pc, float &z_pc)
        
#~  POINT CLOUD INTERFACE ==============================================
    
    int TT_CameraCount()
    float TT_CameraXLocation(int index)
    float TT_CameraYLocation(int index)
    float TT_CameraZLocation(int index)
    float TT_CameraOrientationMatrix(int index, int arrayIndex)
    
    char* TT_CameraName(int index)
    
    bool TT_SetCameraSettings(int CameraIndex, int VideoType,
        int Exposure, int Threshold, int Intensity)
        
    bool TT_CameraFrameBuffer(int CameraIndex, int BufferPixelWidth,
        int BufferPixelHeight, int BufferByteSpan, int BufferPixelDepth,
        (unsigned char) *Buffer)
        
    bool TT_CameraFrameBufferSaveAsBMP(int CameraIndex, char* Filename)
    
#~  RESULT PROCESSING ==================================================

    char* TT_GetResultString(int res)    

#~ CAMERA MANAGER ACCESS ===============================================
    #void*  TT_GetCameraManager()

#======================================================================#
#========================== Python Wrappers ===========================#
#======================================================================#

#~  RIGID BODY STARTUP/SHUTDOWN ========================================

def pyTT_Initialize():
    return TT_Initialize()
    
def pyTT_Shutdown():
    return TT_Shutdown()
    
def pyTT_FinalCleanup():
    return TT_FinalCleanup()
    
#~  RIGID BODY INTERFACE ===============================================    
    
def pyTT_LoadProject(name):
    return TT_LoadProject(name)
    
def pyTT_LoadCalibration(name):
    return TT_LoadCalibration(name)
    
def pyTT_LoadTrackables(name):
    return TT_LoadTrackables(name)
    
def pyTT_Update():
    return TT_Update()
#~     tic = time.clock()
#~     res = TT_Update()
#~     toc = time.clock()
#~     return res, (toc-tic)
    
def pyTT_UpdateSingleFrame():
    return TT_UpdateSingleFrame()

#~  FRAME ==============================================================

def pyTT_FrameMarkerCount():
    return TT_FrameMarkerCount()
    
def pyTT_FrameMarkerX(int index):
    return TT_FrameMarkerX(index)

def pyTT_FrameMarkerY(int index):
    return TT_FrameMarkerY(index)
    
def pyTT_FrameMarkerZ(int index):
    return TT_FrameMarkerZ(index)
    
def pyTT_FrameMarkerLabel(int index):
    return TT_FrameMarkerLabel(index)
    
def pyTT_FrameTimeStamp():
    return TT_FrameTimeStamp()
    
#~  TRACKABLES CONTROL =================================================

def pyTT_IsTrackableTracked(int index):
    return TT_IsTrackableTracked(index)
    
def pyTT_TrackableLocation(int RigidIndex):
    cdef float x, y, z, qx, qy, qz, qw, yaw, pitch, roll

    TT_TrackableLocation(RigidIndex, &x, &y, &z, &qx, &qy, &qz, &qw, &yaw, 
        &pitch, &roll)
    
    return x, y, z, qx, qy, qz, qw, yaw, pitch, roll
    
def pyTT_TrackableCount():
    return TT_TrackableCount()
    
def pyTT_TrackableID(int index):
    return TT_TrackableID(index)
    
def pyTT_SetTrackableID(int index, int ID):
    TT_SetTrackableID(index,ID)
    
def pyTT_TrackableName(int index):
    return TT_TrackableName(index)

def pyTT_TrackableEnabled(int index):
    return TT_TrackableEnabled(index)    
    
def pyTT_TrackableMarkerCount(int index):
    return TT_TrackableMarkerCount(index)
    
def pyTT_TrackableMarker(int RigidIndex, int MarkerIndex):
    cdef float x_m, y_m, z_m
    
    TT_TrackableMarker(RigidIndex, MarkerIndex, &x_m, &y_m, &z_m)
    
    return x_m, y_m, z_m

def pyTT_TrackablePointCloudMarker(int RigidIndex, int MarkerIndex, bool Tracked):
    cdef float x_pc, y_pc, z_pc
        
    TT_TrackablePointCloudMarker(RigidIndex, MarkerIndex, Tracked, x_pc, y_pc, z_pc)
    
    return x_pc, y_pc, z_pc
    
#~  POINT CLOUD INTERFACE ==============================================

def pyTT_CameraCount():
    return TT_CameraCount()

def pyTT_CameraXLocation(int index):
    return TT_CameraXLocation(index)
    
def pyTT_CameraYLocation(int index):
    return TT_CameraYLocation(index)

def pyTT_CameraZLocation(int index):
    return TT_CameraZLocation(index)
    
def pyTT_CameraOrientationMatrix(int index, int arrayIndex):
    return TT_CameraOrientationMatrix(index, arrayIndex)

def pyTT_CameraName(int index):
    return TT_CameraName(index)
    
def pyTT_SetCameraSettings(int CameraIndex, int VideoType,
        int Exposure, int Threshold, int Intensity):
        
    return TT_SetCameraSettings(CameraIndex, VideoType,
        Exposure, Threshold, Intensity)
        
def pyTT_CameraFrameBuffer(int CameraIndex, int BufferPixelWidth,
        int BufferPixelHeight, int BufferByteSpan, int BufferPixelDepth, 
        np.ndarray[dtype=cython.uchar, ndim=2, mode="c"] Buffer):

    return TT_CameraFrameBuffer(CameraIndex, BufferPixelWidth,
        BufferPixelHeight, BufferByteSpan, BufferPixelDepth,
        &Buffer[0,0])
#~         <unsigned char*> input.data)
        
def pyTT_CameraFrameBufferSaveAsBMP(int CameraIndex, Filename):
    return TT_CameraFrameBufferSaveAsBMP(CameraIndex, Filename)

#~  RESULT PROCESSING ==================================================

def pyTT_GetResultString(int res):
    return TT_GetResultString(res)

#def pyTT_TT_GetCameraManager():
#    return TT_GetCameraManager();
