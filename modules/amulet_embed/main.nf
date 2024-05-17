process AMULET_ANTIBERTY{

    container 'ggabernet/amulet:1.0.0'
    publishDir "${params.outdir}/amulet/antiberty/", mode: 'copy'

    input:
    path tsv
    
    output:
    path "${tsv.baseName}_HL_antiberty.tsv" , emit: embedding

    script:
    """
    amulet antiberty $tsv HL ${tsv.baseName}_HL_antiberty.tsv
    """
}
