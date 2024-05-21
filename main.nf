#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include {AMULET_TRANSLATE} from './modules/amulet_translate'
include {AMULET_ANTIBERTY} from './modules/amulet_antiberty'
include {AMULET_ANTIBERTA} from './modules/amulet_antiberta'
include {AMULET_ESM} from './modules/amulet_esm'

workflow {

    main:
    ch_input = Channel.fromPath(params.input, checkIfExists: true)

    AMULET_TRANSLATE(ch_input)

    AMULET_ANTIBERTY(AMULET_TRANSLATE.out.translated)

    AMULET_ANTIBERTA(AMULET_TRANSLATE.out.translated)

    AMULET_ESM(AMULET_TRANSLATE.out.translated)

}


