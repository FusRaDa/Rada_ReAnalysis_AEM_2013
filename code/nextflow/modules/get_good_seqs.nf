// Generate a customized version of the SILVA reference database that targets the V4 region

// Inputs:
// code/get_good_seqs.batch
// data/raw

process GET_GOOD_SEQS{
    container 'community.wave.seqera.io/library/mothur:1.48.3--8c30967de5ffe410'

    input:
        path input_batch
        path input_dir

    script:
    """
    #!/bin/bash
    mothur "${input_batch}"
    """
}