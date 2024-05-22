process AMULET_TRANSLATE {

    label "process_medium"
        
    container "ggabernet/amuletgpu:0.1.0"
    publishDir "${params.outdir}/translations/", mode: "copy"

    input:
    path tsv
    
    output:
    path "*_translated.tsv" , emit: translated

    script:
    """
    amulet translate-igblast $tsv . /igblast_base
    """
}