#!/usr/bin/env bash
set -euo pipefail

run="$1"
analysis="$2"

OUT="${run}_${analysis}_samplesheet.csv"
S3_PATH="s3://seqwell-analysis/${run}/${analysis}/bam"

echo "sample_id,bam,ref" > "$OUT"

aws s3 ls "$S3_PATH/" \
  | awk -v run="$run" -v analysis="$analysis" '
    $NF ~ /\.md\.bam$/ {
      fname = $NF
      sample = fname
      sub(/\.md\.bam$/, "", sample)
      
      # Extract reference (first part before first underscore)
      split(fname, parts, "_")
      ref = parts[1]
      
      printf "%s,s3://seqwell-analysis/%s/%s/bam/%s,s3://seqwell-ref/%s.fa\n", 
        sample, run, analysis, fname, ref
    }
  ' >> "$OUT"