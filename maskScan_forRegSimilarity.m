% masks MR atlas or CT scan for similarity registration step
% maskScan_forRegSimilarity.m
% Mai-Anh Vu
% udpated May 18, 2015

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% DESCRIPTION %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% this function takes as input the MR atlas or the CT and a brain mask from
% the atlas (in either NIFTI format or in matrix form) and masks out the 
% brain area, replacing these voxels with NaN, leaving the skull for 
% the similarity registration step

% this function outputs the resulting scan as a matrix

% for example:
% MR_masked = maskMR_forRegSimilarity(MRmatrix,maskMatrix);
% or
% MR_masked = maskMR_forRegSimilarity('path\MR.nii','path\Mask.nii');

function maskedScan = maskScan_forRegSimilarity(MR, brainMask)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% PARAMETERS TO BE TUNED %%%%%%
%%%%%%      AS NECESSARY      %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% erosion sphere size (in voxels)
sphDiam = 5;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% MAIN BODY %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\

% read in scans
maskMatrix = readScan(brainMask);
scanMatrix = readScan(MR);

% make 3-D structuring element
se=strel3d(sphDiam); 

% erode brain mask
erodedMask = imerode(maskMatrix,se);

% mask the MR
maskedScan = scanMatrix;
maskedScan(logical(erodedMask)) = NaN;

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


