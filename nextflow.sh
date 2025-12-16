#!/bin/bash

samplesheet=samplesheet.csv
run=20251211_MiSeq-i100
analysis=SH_align_w_map
outdir=${run}_${analysis}



/software/nextflow-align/nextflow run \
main.nf \
--samplesheet $samplesheet \
--run $run \
--analysis $analysis \
--outdir $outdir \
-workdir "work" \
-bg -resume