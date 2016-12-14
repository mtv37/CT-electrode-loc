% applies rigid and nonrigid registration steps to the original unmasked CT
% applyReg2CT.m
% Mai-Anh Vu
% udpated May 19, 2015


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% DESCRIPTION %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% this function takes as input the original unmasked CT (in either NIFTI
% format or in matrix form) and applies the rigid and nonrigid registration
% transformations calculated from previous steps.

% this function outputs the CT as a matrix

% for example:
% CTreg = applyReg2CT(CTmatrix,rigTform,simTform);
% or
% CTreg = applyReg2CT('path\CT.nii',rigTform,simTform);


function CTreg = applyReg2CT(CT,rigidTform,simTform)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% MAIN BODY %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% read in scans
CTmatrix = readScan(CT);
im_size = size(CTmatrix);

% apply transformations
CTreg = imwarp(CTmatrix,rigidTform,'OutputView',imref3d(im_size));
CTreg = imwarp(CTreg,simTform,'OutputView',imref3d(im_size));

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% function readScan %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% if not already in matrix form, load NIFTI
function scanMat = readScan(scan)

if ~isnumeric(scan)
    scan = load_nii(scan);
    scanMat = scan.img;
else
    scanMat = scan;
end

end