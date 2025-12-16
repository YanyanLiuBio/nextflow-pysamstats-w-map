

include { PYSAMSATS } from './modules/pysamstats.nf'

include { MAKE_SAMPLESHEET } from './modules/make_samplesheet.nf'

workflow {

    /*
     * CSV example:
     * sample_id,bam,ref
     * S1,s3://bucket/sample1.bam,s3://bucket/ref.fa
     */
  
    
    bam_ref_ch = channel.fromPath( params.samplesheet )
        .splitCsv(header: true)
        .map { row ->
            tuple(
                row.sample_id,
                file(row.bam),
                file(row.ref)
            )
        }

    PYSAMSATS(bam_ref_ch)
}
