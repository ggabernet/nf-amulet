include { AMULETY_TRANSLATE } from './modules/nf-core/amulety/translate/main'
include { AMULETY_EMBED as AMULETY_ANTIBERTA2 } from './modules/nf-core/amulety/embed/main'
include { AMULETY_EMBED as AMULETY_ANTIBERTY } from './modules/nf-core/amulety/embed/main'
include { AMULETY_EMBED as AMULETY_BALMPAIRED } from './modules/nf-core/amulety/embed/main'
include { AMULETY_EMBED as AMULETY_ESM2 } from './modules/nf-core/amulety/embed/main'
include { UNZIP_DB as UNZIP_IGBLAST } from './modules/local/unzip_db'

workflow {

    main:
    ch_input = Channel.fromPath(params.input, checkIfExists: true)
    ch_reference_igblast_zipped = Channel.fromPath(params.reference_igblast, checkIfExists: true)

    ch_meta_input = ch_input.map { it -> [[id: it.baseName], it] }

    UNZIP_IGBLAST( ch_reference_igblast_zipped.collect() )

    ch_reference_igblast = UNZIP_IGBLAST.out.unzipped

    if (!params.skip_translation){
        AMULETY_TRANSLATE(
            ch_meta_input,
            ch_reference_igblast
        )
        ch_translation = AMULETY_TRANSLATE.out.repertoire_translated
    } else {
        ch_translation = ch_input
    }

    if (params.embeddings && params.embeddings.split(',').contains('antiberty')) {
        AMULETY_ANTIBERTY(
            ch_translation,
            params.mode,
            "antiberty"
            )
    }

    if (params.embeddings && params.embeddings.split(',').contains('antiberta2')) {
        AMULETY_ANTIBERTA2(
            ch_translation,
            params.mode,
            "antiberta2"
        )
    }

    if (params.embeddings && params.embeddings.split(',').contains('balmpaired')) {
        AMULETY_BALMPAIRED(
            ch_translation,
            params.mode,
            "balmpaired"
        )
    }

    if (params.embeddings && params.embeddings.split(',').contains('esm2')) {
        AMULETY_ESM2(
            ch_translation,
            params.mode,
            "esm2"
        )
    }

}


