process AMULET_TRANSLATE {

    cpus 6
    memory 16
    time 24.h
    

    container "ggabernet/amulet:1.0.0"
    publishDir "${params.outdir}/translations/", mode: "copy"

    input:
    path tsv
    
    output:
    path "*_translated.tsv" , emit: translated

    script:
    """
    wget -c https://github.com/nf-core/test-datasets/raw/airrflow/database-cache/igblast_base.zip
    unzip igblast_base.zip
    
    amulet translate-igblast $tsv . igblast_base
    """
}