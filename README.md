# CT-electrode-loc
This is the code accompanying the following publication:
Schaich Borg J*, Vu M*, Badea C, Badea A, Johnson GA, Dzirasa K. Localization of metal electrodes in the intact rat brain using registration of 3-D micro-computed tomography images to a magnetic resonance histology atlas. eNeuro 2015; 2(4). *denotes equally contributing authors
https://www.eneuro.org/content/2/4/ENEURO.0017-15.2015

##Use:

regCT2MR_full.m is the script that runs our full registration algorithm. This script calls upon the other scripts:
applyReg2CT.m
maskCT_forRegRigid.m
maskMR_forRegRigid.m
maskScan_forRegSimilarity.m
regRigidCT2MR.m
regSimilarityCT2MR.m



##A few notes:

Please note that for our registration, we resampled and cropped the MR atlas and CT scan, such that the resolution and size were matching. For scans not matching in resolution or size, the code may need to be adapted appropriately.

Furthermore, in our scans, the electrodes and implant were the brightest voxels, and we chose our masking parameters accordingly. For scans in which this is not the case, the code may need to be adapted.




##Dependencies:

These scripts rely on :
1. The Tools for NIFTI and ANALYZE images, developed by Jimmy Shen, 23 Oct. 2005, updated 22 Jan 2014. (http://www.mathworks.com/matlabcentral/fileexchange/8797-tools-for-nifti-and-analyze-image)
2. strel3d for making 3D spherical structuring elements, developed by Luke Xie, 26 Sep 2014 (Updated 29 Sep 2014). (http://www.mathworks.com/matlabcentral/fileexchange/47937-3d-structuring-element--sphere-/content/strel3d.m)



##Disclaimer:

The code is not guaranteed to fit any clinical purpose but it is open for research. 




Copyright (c) 2015, Mai-Anh Vu
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in
      the documentation and/or other materials provided with the distribution

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.
