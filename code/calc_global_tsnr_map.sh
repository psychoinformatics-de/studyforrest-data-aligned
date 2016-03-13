#!/bin/bash

set -e
set -u

odir="qa/bold3Tp2/tsnr"
mkdir -p $odir

for s in sub-*; do
  echo "$s"
  $FSLDIR/bin/fslmerge -t $odir/${s}_alltsnr $s/in_bold3Tp2/${s}_*_bold_tsnr.nii.gz
  $FSLDIR/bin/fslmaths $odir/${s}_alltsnr -Tmean $odir/${s}_avgtsnr
  $FSLDIR/bin/applywarp \
    -i $odir/${s}_avgtsnr \
    -r src/tnt/templates/grpbold3Tp2/brain.nii.gz \
    -o $odir/${s}_avgtsnr_grpbold3Tp2 \
    -w src/tnt/${s}/bold3Tp2/in_grpbold3Tp2/subj2tmpl_warp.nii.gz \
    --interp=trilinear
done

$FSLDIR/bin/fslmerge -t $odir/alltsnr_grpbold3Tp2 $odir/*_avgtsnr_grpbold3Tp2.nii.gz
$FSLDIR/bin/fslmaths $odir/alltsnr_grpbold3Tp2 -Tmean $odir/avgtsnr_grpbold3Tp2
$FSLDIR/bin/fslmaths $odir/alltsnr_grpbold3Tp2 -Tstd $odir/stdtsnr_grpbold3Tp2
$FSLDIR/bin/fslmaths $odir/avgtsnr_grpbold3Tp2 -uthr 60 -bin $odir/avgtsnr_grpbold3Tp2_lt60
$FSLDIR/bin/fslmaths $odir/avgtsnr_grpbold3Tp2 -uthr 50 -bin $odir/avgtsnr_grpbold3Tp2_lt50

