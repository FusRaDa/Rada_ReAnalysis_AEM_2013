#!/usr/bin/env nextflow


include { GET_GOOD_SEQS } from './modules/get_good_seqs.nf'


params.get_good_seqs_batch = 'code/get_good_seqs.batch'
params.raw_data_dir = 'data'


workflow {
    get_good_seqs_batch_ch = channel.fromPath(params.get_good_seqs_batch)
    raw_data_dir_ch = channel.fromPath(params.raw_data_dir)

    // Run mothur commands in get_good_seqs.batch
    GET_GOOD_SEQS(get_good_seqs_batch_ch, raw_data_dir_ch)
}