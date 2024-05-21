process AMULET_ANTIBERTY{

    label (params.with_gpu? 'gpus': 'process_medium')

    container 'ggabernet/amuletgpu:0.1.0'
    publishDir "${params.outdir}/amulet/antiberty/", mode: 'copy'

    input:
    path tsv
    
    output:
    path "${tsv.baseName}_${params.mode}_antiberty.tsv" , emit: embedding

    script:
    """
    amulet antiberty $tsv ${params.mode} ${tsv.baseName}_${params.mode}_antiberty.tsv
    """
}
