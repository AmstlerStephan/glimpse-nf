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

// Print summary of supplied parameters
log.info paramsSummaryLog(workflow)


include { GLIMPSE_NF } from './workflows/glimpse_nf'

/*
========================================================================================
    RUN ALL WORKFLOWS
========================================================================================
*/

workflow {
    GLIMPSE_NF ()
}