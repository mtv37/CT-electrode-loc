% masks MR atlas for rigid registration step
% maskMR_forRegRigid.m
% Mai-Anh Vu
% udpated May 18, 2015

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% DESCRIPTION %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% this function takes as input the MR atlas and a corresponding brain mask
% (in either NIFTI format or in matrix form) and masks out the brain area
% of the MR atlas, replacing these voxels with the MODE intensity value,
% leaving the skull as the main information for the rigid registration step

% this function outputs the resulting MR as a matrix

% for example:
% MR_masked = maskMR_forRegRigid(MRmatrix,maskMatrix);
% or
% MR_masked = maskMR_forRegRigid('path\MR.nii','path\Mask.nii');

function MRmasked = maskMR_forRegRigid(MR, brainMask)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% PARAMETERS TO BE TUNED %%%%%%
%%%%%%      AS NECESSARY      %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% erosion sphere size (in voxels)
sphDiam = 20;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% MAIN BODY %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\

% read in scans
maskMatrix = readScan(brainMask);
MRmatrix = readScan(MR);

% get image size from MR atlas
im_size = size(MRmatrix);

% make 3-D structuring element
se=strel3d(sphDiam); 

% erode brain mask
erodedMask = imerode(maskMatrix,se);

% find MODE value of the MR = peak of peak density
MRvec = double(reshape(MRmatrix,prod(im_size),1)); % single vector
[f,xi]=ksdensity(MRvec); % probability density function
MRmode = xi(f==max(f)); % mode

% mask the MR
MRmasked = MRmatrix;
MRmasked(logical(erodedMask)) = MRmode;

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


