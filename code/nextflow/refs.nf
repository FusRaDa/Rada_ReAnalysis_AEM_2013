#!/usr/bin/env nextflow


include { MOTHUR_GET_LINEAGE } from './modules/mothur_get_lineage.nf'
include { MOTHUR_PCR_SEQS } from './modules/mothur_pcr_seqs.nf'


params.lineage_align= 'data/references/silva.seed_v123.align'
params.lineage_tax = 'data/references/silva.seed_v123.tax'

params.get_good_seqs_batch = 'code/get_good_seqs.batch'
params.raw_data_dir = 'data'


workflow {
    lineage_align_ch = channel.fromPath(params.lineage_align)
    lineage_tax_ch = channel.fromPath(params.lineage_tax)

    // Get sequences from the specified taxon in reference files and remove gap characters
    MOTHUR_GET_LINEAGE(lineage_align_ch, lineage_tax_ch)

    // Generate a customized version of the SILVA reference database that targets the V4 region
    MOTHUR_PCR_SEQS(MOTHUR_GET_LINEAGE.output.silva)
}