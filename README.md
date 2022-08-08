# DWI preprocessing

## using MRTRIX, FSL and ANTS

### by Michael Paquette


This serie of jupyter Bash notebooks showcase a typical preprocessing for duffusion MRI of in-vivo brain data.  


Content of each notebook:

**december_09.ipynb**
Basic linux terminal commands and DICOM to Nifti conversion.

**december_15.ipynb**
Denoising and Gibbs ringing correction.

**january_13.ipynb**
Brain mask creation with motion correction and bias field intensity correction.

**january_20.ipynb**
Diffusion gradient oriention QC, Susceptibility-induced off-resonance distorsion correction (topup) and Eddy current geometric distorions corrections (fsl-eddy).

**january_27.ipynb**
Eddy-qc, tight brain mask creation and ANTS non-linear registration of MNI template

**february_17.ipynb**
Closer look at ANTS registration, 

**february_24.ipynb**
Voxelwise image maths, diffusion modeling (odf, csd)

**march_17.ipynb**
(probabilistic) tractography with mrtrix, tractogram utilities (resampling, subsets with criteria or ROI, projecting tracts to image, projecting image value on tratcs)

**april_7.ipynb**
Building connectome matrix with different weigths

**april_7.sh**
Example file for building connectome (as in notebook april_7.ipynb)

**b02b0_mod.cnf**
example of topup parameter file (required in notebook january_20.ipynb)



