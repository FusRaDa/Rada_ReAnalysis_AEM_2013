#!/usr/bin/env nextflow
// get sequences from the specified taxon in reference files and remove gap characters

// Inputs:
// 'data/references/silva.seed_v123.align'
// 'data/references/silva.seed_v123.tax'

// Outputs:
// data/references/silva.seed.align/silva.seed.align"


process MOTHER_GET_LINEAGE{
    container 'community.wave.seqera.io/library/mothur:1.48.3--8c30967de5ffe410'

    publishDir 'data/references', mode: 'symlink'

    input:
        path input_align
        path input_tax

    output:
        path "silva.seed.align", emit: silva

    script:
    """
    #!/bin/bash
    mothur "#get.lineage(fasta=${input_align}, taxonomy=${input_tax}, taxon=Bacteria);degap.seqs(fasta=silva.seed_v123.pick.align, processors=8)"
    mv silva.seed_v123.pick.align silva.seed.align
    """
}


params.lineage_align= 'data/references/silva.seed_v123.align'
params.lineage_tax = 'data/references/silva.seed_v123.tax'


workflow {
    lineage_align_ch = channel.fromPath(params.lineage_align)
    lineage_tax_ch = channel.fromPath(params.lineage_tax)
    MOTHER_GET_LINEAGE(lineage_align_ch, lineage_tax_ch)
}