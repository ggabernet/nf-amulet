#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include {AMULET_TRANSLATE} from './modules/amulet_translate'
include {AMULET_ANTIBERTY} from './modules/amulet_embed'

workflow {

    main:
    ch_input = Channel.fromPath(params.input, checkIfExists: true)

    AMULET_TRANSLATE(ch_input)

    AMULET_ANTIBERTY(AMULET_TRANSLATE.out.translated)

}


