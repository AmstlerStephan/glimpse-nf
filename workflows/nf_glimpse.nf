#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { chunk_chromosome } from '../modules/local/chunk_genome'
include { SPLIT_REFERENCE } from '../modules/local/split_reference'
//include { IMPUTE_PHASE } from './modules/local/impute_phase'
//include { LIGATE_CHUNKS } from './modules/local/ligate_chunks'

workflow GLIMPSE_NF {
    // static file paths
    input_vcf = file(params.reference_vcf)
    genetic_map = file(params.genetic_map)
    bam = file(params.bam)
    
    // Chunk genome
    //chunk_chromosome(PREPARE_REFERENCE.out.sites_vcf, genetic_map)

    chunk_chromosome = 
    channel.fromPath("$baseDir/data/testing/chunked_chromosome/chunks.chr22.txt")
    .splitText( by:1 )
    .splitCsv(header: ['ID', 'Chr', 'RegionIn', 'RegionOut', 'Size1', 'Size2', 'info1', 'info2'], sep: "\t", skip: 0)
    .map { it -> [it["ID"], it["Chr"], it["RegionIn"], it["RegionOut"]]}

    // Split reference
    SPLIT_REFERENCE(chunk_chromosome, genetic_map, CHUNK_GENOME.out.chunks)

    // Impute and phase
    //IMPUTE_PHASE(bam, SPLIT_REFERENCE.out.split_reference, CHUNK_GENOME.out.chunks)

    // Ligate chunks
    //LIGATE_CHUNKS(IMPUTE_PHASE.out.imputed_chunks)

    // Calculate concordance
    //concordance_list = file(params.concordance_list)
    //CALCULATE_CONCORDANCE(LIGATE_CHUNKS.out.ligated_bcf, concordance_list)
}