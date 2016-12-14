% applies all registration and masking steps to register CT to MR
% regCT2MR_allSteps.m
% Mai-Anh Vu
% udpated May 19, 2015

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% DESCRIPTION %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% this function takes as input the CT, the MR atlas, and the atlas brain 
% mask  (in either NIFTI format or in matrix form), and registers the CT
% to the MR, using these functions:
% 1. maskCT_forRegRigid.m
% 2. maskMR_forRegRigid.m
% 3. regRigidCT2MR.m
% 4. maskScan_forRegSimilarity
% 5. regSimilarityCT2MR.m


% this function outputs the registered CT as a matrix, which can then be
% saved as whatever file type is desired

% for example:
% CTregMatrix = regCT2MR_full(CTmatrix,MRmatrix,brainMask);
% or
% CTregMatrix = regCT2MR_full('path/CT.nii', 'path/MR.nii','path/brainMask.nii');


function CTregMatrix = regCT2MR_full(CT,MR,brainMask)

% mask CT for rigid registration
CTmasked1 = maskCT_forRegRigid(CT);

% mask MR for rigid registration
MRmasked1 = maskMR_forRegRigid(MR, brainMask);

% rigid registration
[CTreg1, rigidTform] = regRigidCT2MR(CTmasked1, MRmasked1);

% mask CT for similariy registration
CTmasked2 = maskScan_forRegSimilarity(CTreg1, brainMask);

% mask MR for similariy registration
MRmasked2 = maskScan_forRegSimilarity(MR, brainMask);

% similarity registration
[CTreg2, simTform] = regSimilarityCT2MR(CTmasked2,MRmasked2);

% apply transformations to original CT
CTregMatrix = applyReg2CT(CT,rigidTform,simTform);

end



