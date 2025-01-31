process SPLIT_REFERENCE {
    publishDir 'reference_panel/split', mode: 'copy'

    input:
    tuple val(chunk_id), val(chromosome), val(input_region), val(output_region)
    path reference
    path genetic_map

    output:
    path '1000GP.chr22.noNA12878_*.bin', emit: split_reference

    script:
    """
      GLIMPSE2_split_reference --reference ${reference} --map ${genetic_map} --input-region ${input_region} --output-region ${output_region} --output 1000GP.chr22.noNA12878
    """
}