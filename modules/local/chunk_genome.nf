process chunk_chromosome {
container "glimpse:v2.0.0-27-g0919952_20221207"

input:
path input_vcf
val chr_name
path input_map

output:
path output_file

script:
"""
# GLIMPSE2_chunk --input reference_panel/1000GP.chr22.noNA12878.sites.vcf.gz --region chr22 --output chunks.chr22.txt --map ../maps/genetic_maps.b38/chr22.b38.gmap.gz
GLIMPSE2_chunk --input ${input_vcf} --region ${chr_name} --output ${output_file} --map ${input_map}

"""

}
