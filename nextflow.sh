#!/bin/bash


run=20251211_MiSeq-i100
analysis=SH_align_w_map
outdir=${run}_${analysis}



/software/nextflow-align/nextflow run \
main.nf \
--run $run \
--analysis $analysis \
--outdir $outdir \
-work-dir "work" \
-bg -resume