#!/bin/bash

set -e
set -u

corrtype=$1

odir="qa/bold3Tp2/aoav_corr_${corrtype}"
mkdir -p $odir

for s in sub-*; do
  if [ "$s" = "sub-10" ]; then
    # this subject doesn't have usable 7T data
    continue
  fi
  echo "$s"
  $FSLDIR/bin/fslmerge -t $odir/${s}_all $s/in_bold3Tp2/${s}_*_${corrtype}Z.nii.gz
  $FSLDIR/bin/fslmaths $odir/${s}_all -Tmean $odir/${s}_avg
  $FSLDIR/bin/applywarp \
    -i $odir/${s}_avg \
    -r src/tnt/templates/grpbold3Tp2/brain.nii.gz \
    -o $odir/${s}_avg_grpbold3Tp2 \
    -w src/tnt/${s}/bold3Tp2/in_grpbold3Tp2/subj2tmpl_warp.nii.gz \
    --interp=trilinear
  $FSLDIR/bin/flirt \
    -in src/tnt/${s}/bold7Tp1/brain_mask.nii.gz \
    -ref src/tnt/${s}/bold3Tp2/brain.nii.gz \
    -init src/tnt/${s}/bold7Tp1/in_bold3Tp2/xfm_6dof.mat \
    -applyxfm \
    -o $odir/${s}_brain_mask_in3T \
    -interp nearestneighbour
  $FSLDIR/bin/applywarp \
    -i $odir/${s}_brain_mask_in3T \
    -r src/tnt/templates/grpbold3Tp2/brain.nii.gz \
    -o $odir/${s}_brain_mask \
    -w src/tnt/${s}/bold3Tp2/in_grpbold3Tp2/subj2tmpl_warp.nii.gz \
    --interp=nn

done

$FSLDIR/bin/fslmerge -t $odir/allmask_grpbold3Tp2 $odir/*_brain_mask.nii.gz
$FSLDIR/bin/fslmaths $odir/allmask_grpbold3Tp2 -Tmean -thr 1 -bin $odir/mask_grpbold3Tp2
$FSLDIR/bin/fslmerge -t $odir/all_grpbold3Tp2 $odir/*_avg_grpbold3Tp2.nii.gz
$FSLDIR/bin/fslmaths $odir/all_grpbold3Tp2 -Tmean $odir/avg_grpbold3Tp2
$FSLDIR/bin/fslmaths $odir/all_grpbold3Tp2 -Tstd $odir/std_grpbold3Tp2
cd $odir
$FSLDIR/bin/easythresh avg_grpbold3Tp2.nii.gz mask_grpbold3Tp2 3.1 0.05 \
	../../../src/tnt/templates/grpbold3Tp2/brain.nii.gz easythresh_31_05
$FSLDIR/bin/easythresh avg_grpbold3Tp2.nii.gz mask_grpbold3Tp2 2.3 0.05 \
	../../../src/tnt/templates/grpbold3Tp2/brain.nii.gz easythresh_23_05

