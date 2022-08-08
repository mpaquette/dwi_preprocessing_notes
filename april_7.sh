ROOTDIR='/data/pt_02586/'
SUBJECTDIR=$ROOTDIR'sub_01/'
cd $SUBJECTDIR'preprocessing'



# Manual vs Automatic Connectome




# After manually segmenting our bundles, 
# we compute trackcount with tckinfo
# and we manually keep track

touch connectome_example/manual_tractcount.txt
tckinfo tracto/prob_bundle_precg_ifgop.tck | grep total_count >> connectome_example/manual_tractcount.txt
tckinfo tracto/prob_bundle_ptc_ifgop.tck | grep total_count >> connectome_example/manual_tractcount.txt
tckinfo tracto/prob_bundle_ptc_precg.tck | grep total_count >> connectome_example/manual_tractcount.txt
cat connectome_example/manual_tractcount.txt


touch connectome_example/manual_meanFA.txt
awk '{ total += $2; count++ } END { print total/count }' prob_bundle_precg_ifgop_clean0p6_meanFA.txt >> connectome_example/manual_meanFA.txt
awk '{ total += $2; count++ } END { print total/count }' prob_bundle_ptc_ifgop_clean0p6_meanFA.txt >> connectome_example/manual_meanFA.txt
awk '{ total += $2; count++ } END { print total/count }' prob_bundle_ptc_precg_clean0p6_meanFA.txt >> connectome_example/manual_meanFA.txt
cat connectome_example/manual_meanFA.txt











# KEEP this, maybe saved to a file, to "remember" ordering/mapping
LABELROI=(precg_peak_dilx2_warped_fa_th0p2_bin0p25.nii.gz \
          ifgop_peak_dilx2_warped_fa_th0p2_bin0p25.nii.gz \
          ptc_peak_dilx2_warped_fa_th0p2_bin0p25.nii.gz)

# make empty label map 
mrcalc ${LABELROI[1]} 0 -mult connectome_example/labels.nii.gz 

# initialise ROI index
ROIIDX=1

# for each roimask
for ROI in "${LABELROI[@]}"
do
    echo $ROI' index = '$ROIIDX;
    # create a map of 0s and ROIIDX, add it to current labels
    mrcalc $ROI $ROIIDX 0 -if connectome_example/labels.nii.gz  -add connectome_example/labels.nii.gz  -force;
    # increment
    ROIIDX=$((ROIIDX + 1))
done



# Compute mean FA per streamline over the full 3 bundles together
tcksample tracto/prob_bundles.tck \
  fa_post_eddy.nii.gz \
  connectome_example/prob_bundle_meanFA.txt \
  -stat_tck mean



# classic error, considering only endpoints
tck2connectome tracto/prob_bundles.tck \
  connectome_example/labels.nii.gz \
  connectome_example/connectome_tractcount_wrong.csv

cat connectome_example/connectome_tractcount_wrong.csv



tck2connectome tracto/prob_bundles.tck \
  connectome_example/labels.nii.gz \
  connectome_example/connectome_tractcount_backtrack.csv \
  -assignment_reverse_search 0 \
  -force

cat connectome_example/connectome_tractcount_backtrack.csv




tck2connectome tracto/prob_bundles.tck \
  connectome_example/labels.nii.gz \
  connectome_example/connectome_meanFA.csv \
  -assignment_reverse_search 0 \
  -scale_file connectome_example/prob_bundle_meanFA.txt \
  -stat_edge mean \
  -force

cat connectome_example/connectome_meanFA.csv




