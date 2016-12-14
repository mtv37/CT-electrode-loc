% masks CT scan for rigid registration step
% maskCT_forRegRigid.m
% Mai-Anh Vu
% udpated May 18, 2015

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% DESCRIPTION %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% this function takes as input the CT scan and masks out the electrode
% implant voxels, replacing these voxels with the MODE intensity value

% this function outputs the resulting MR as a matrix

% for example:
% CT_masked = maskCT_forRegRigid(CTmatrix);
% or
% CT_masked = maskCT_forRegRigid('path\CT.nii');

function CTmasked = maskCT_forRegRigid(CT)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% PARAMETERS TO BE TUNED %%%%%%
%%%%%%      AS NECESSARY      %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% probability density cutoff
fCutoff = 0.00001;

% mask dilation sphere size (in voxels)
sphDiam = 5;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% MAIN BODY %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\

% read in scans
CTmatrix = readScan(CT);

% get image size from MR atlas
im_size = size(CTmatrix);

% make 3-D structuring element
se=strel3d(sphDiam); 

    
% find electrode implant
% single vector
CTvec = double(reshape(CTmatrix,prod(im_size),1)); 
% probability density function
[f,xi] = ksdensity(CTvec); 
% find mode index
modeInd = find(f==max(f));
% mode intensity value
mode = xi(modeInd);
% find indices of all prob density values < cutoff
lowFs = find(f<fCutoff); 
% find first low prob density index that is greater than the mode
cutoff = find(lowFs>modeInd,1,'first'); 
% cutoff intensity value (anything higher is the implant)
cutoff = xi(lowFs(cutoff));

% make the mask
mask = zeros(im_size);
mask(CTmatrix>=cutoff) = 1;

% dilate mask
se=strel3d(sphDiam); 
dilatedMask = imdilate(mask,se);
    
% apply mask
CTmasked = CTmatrix;
CTmasked(logical(dilatedMask))= mode;

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


