#!/usr/bin/env nextflow
/*
========================================================================================
    genepi/glimpse-nf
========================================================================================
    Github : https://github.com/genepi/glimpse-nf
    Author: Sebastian Schönherr & Lukas Forer
    ---------------------------
*/

nextflow.enable.dsl = 2


if (params.help) {
   def citation = '\n' + WorkflowMain.citation(workflow) + '\n'
   def String command = "nextflow run ${workflow.manifest.name} --config test.conf"
   log.info paramsHelp(command) + citation
   exit 0
}

// Validate input parameters
if (params.validate_params) {
    validateParameters()
}

include { GLIMPSE_NF } from "${baseDir}/workflows/nf_glimpse"

/*
========================================================================================
    RUN ALL WORKFLOWS
========================================================================================
*/

workflow {
    GLIMPSE_NF ()
}