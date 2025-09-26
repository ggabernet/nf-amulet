#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include {AMULETY_TRANSLATE} from './modules/amulety_translate'
include {AMULETY_ANTIBERTY} from './modules/amulety_antiberty'
include {AMULETY_ANTIBERTA} from './modules/amulety_antiberta'
include {AMULETY_BALMPAIRED} from './modules/amulety_balmpaired'
include {AMULETY_ESM} from './modules/amulety_esm'

workflow {

    main:
    ch_input = Channel.fromPath(params.input, checkIfExists: true)
    ch_reference_igblast = Channel.fromPath(params.reference_igblast, checkIfExists: true)

    if (!params.skip_translation){
        AMULETY_TRANSLATE(
            ch_input,
            ch_reference_igblast)
        ch_translation = AMULETY_TRANSLATE.out.translated
    } else {
        ch_translation = ch_input
    }

    AMULETY_ANTIBERTY(ch_translation)

    //AMULETY_ANTIBERTA(ch_translation)

    //AMULETY_ESM(ch_translation)

    //AMULETY_BALMPAIRED(ch_translation)

}


