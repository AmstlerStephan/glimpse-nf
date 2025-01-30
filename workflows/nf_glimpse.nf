#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { CHUNK_GENOME } from './modules/chunk_genome'
include { SPLIT_REFERENCE } from './modules/split_reference'
include { IMPUTE_PHASE } from './modules/impute_phase'
include { LIGATE_CHUNKS } from './modules/ligate_chunks'

workflow {
    // Chunk genome
    genetic_map = file(params.genetic_map)
    CHUNK_GENOME(PREPARE_REFERENCE.out.sites_vcf, genetic_map)

    // Split reference
    SPLIT_REFERENCE(PREPARE_REFERENCE.out.reference_bcf, genetic_map, CHUNK_GENOME.out.chunks)

    // Impute and phase
    bam = file(params.bam)
    IMPUTE_PHASE(bam, SPLIT_REFERENCE.out.split_reference, CHUNK_GENOME.out.chunks)

    // Ligate chunks
    LIGATE_CHUNKS(IMPUTE_PHASE.out.imputed_chunks)

    // Calculate concordance
    concordance_list = file(params.concordance_list)
    CALCULATE_CONCORDANCE(LIGATE_CHUNKS.out.ligated_bcf, concordance_list)
}