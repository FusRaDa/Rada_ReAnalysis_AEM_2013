// Generate a customized version of the SILVA reference database that targets the V4 region

// Inputs:
// data/references/silva.seed.align/silva.seed.align

// Outputs:
// data/references/silva.v4.align


process MOTHUR_PCR_SEQS{
    container 'community.wave.seqera.io/library/mothur:1.48.3--8c30967de5ffe410'

    publishDir 'data/references', mode: 'copy'

    input:
        path input

    output:
        path "silva.v4.align", emit: silva

    script:
    """
    #!/bin/bash
    mothur "#pcr.seqs(fasta=data/references/silva.seed.align, start=11894, end=25319, keepdots=F, processors=8)"
    mv silva.seed.pcr.align silva.v4.align
    """
}