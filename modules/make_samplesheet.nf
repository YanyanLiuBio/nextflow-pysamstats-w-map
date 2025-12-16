process MAKE_SAMPLESHEET {

    tag "${params.run}:${params.analysis}"

    output:
    path "samplesheet.csv"

    script:
    """
    (
      echo "sample_id,bam,ref"
      aws s3 ls s3://seqwell-analysis/${params.run}/${params.analysis}/bam/ \
      | awk '
        \$4 ~ /\\.md\\.bam\$/ {
          fname=\$4
          sample=fname
          sub(/\\.md\\.bam\$/, "", sample)
          split(fname, a, "_")
          ref=a[1]
          printf "%s,s3://seqwell-analysis/${params.run}/${params.analysis}/bam/%s,s3://seqwell-ref/%s.fa\\n",
                 sample, fname, ref
        }
      '
    ) > samplesheet.csv
    """
}
