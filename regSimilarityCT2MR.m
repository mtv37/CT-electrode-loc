% calculates affine registration of a CT to MR atlas
% regSimilarityCT2MR.m
% Mai-Anh Vu
% udpated May 18, 2015

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% DESCRIPTION %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% this function takes as input the CT and the MR atlas (in either NIFTI
% format or in matrix form) and applies a similarity registration.

% this function outputs the CT as a matrix, along with the 3D
% transformation matrix

% for example:
% [CTreg, CTregTform] = regSimilarityCT2MR(CTmatrix,MRmatrix);
% or
% [CTreg, CTregTform] = regSimilarityCT2MR('path/CT.nii', 'path/MR.nii');

function [CTreg, CTregTform] = regSimilarityCT2MR(CT,MR)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% PARAMETERS TO BE TUNED %%%%%%
%%%%%%      AS NECESSARY      %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% tune the initial search radius
initialRadius = 0.00325;

% if tuning initial search radius doesn't work, try tuning:
iterations = 500;
growthFactor = 1.01;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% MAIN BODY %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% read in scans
MRmatrix = readScan(MR);
CTmatrix = readScan(CT);

% get image size
im_size = size(MRmatrix);

% invert black/white on CT (to match b0) and cast as int16
CTinv = -1*CTmatrix;

% registration
% set the paramters
[optimizer, metric] = imregconfig('multimodal');
optimizer.GrowthFactor=growthFactor;
optimizer.InitialRadius = initialRadius;
optimizer.MaximumIterations=iterations; 
% calculate the transformation
CTregTform = imregtform(CTinv,MRmatrix,'similarity',optimizer,metric);
% apply the transformation
CTregInv = imwarp(CTinv,CTregTform,'OutputView',imref3d(im_size));

% uninvert
CTreg=-1*CTregInv;

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


