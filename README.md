pymotive - Python wrappers for OptiTrack's Motive software
==========================================================

Author: AMH (based on Asa's README for Tracking Tools)
2013-06-12


1) Edit setup.py to reflect your system's installation paths for the 
NPTrackingTools(x64).dll and .lib files

2) Copy the appropriate NPTrackingTools(x64) dll from the 'lib' subdirectory 
of the Motive installation directory to the same directory as setup.py and 
pymotive.pyx

3) Run 'python setup.py build_ext --inplace'

4) OPTIONAL - Add the directory where you ran setup.py to your PYTHONPATH 
environment variable (to enable you to load the pymotive module without 
having to run the Python shell from that directory every time).


NOTES:

1) For the above to work, you will need to have a C++ compiler installed. The
C++ compiler include with Visual Studio 2010 works well with Cython. 

2) FOR USERS OF THE ENTHOUGHT PYTHON DISTRIBUTION:
There is a conflict with an OpenMP library provided by Intel libiomp5mt.lib 
and another library provided by the Enthought distribution mk2iomp5md.dll. To 
"resolve" the issue I had to create an environment variable named 
KMP_DUPLICATE_LIB_OK with a value of TRUE. This is not the best way to resolve 
this issue, but I couldn't figure out how to ensure the correct library gets 
loaded and avoids a conflict with the other.

AMH
