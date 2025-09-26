process AMULETY_TRANSLATE {

    label "process_medium"
        
    container 'community.wave.seqera.io/library/amulety_igblast:659eaa872785adeb'
    publishDir "${params.outdir}/translations/", mode: "copy"

    input:
    path tsv
    
    output:
    path "*_translated.tsv" , emit: translated

    script:
    """
    amulety translate-igblast $tsv . /igblast_base
    """
}