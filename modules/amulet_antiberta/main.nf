process AMULET_ANTIBERTA{

    label (params.with_gpu? 'gpus': 'process_medium')

    container 'ggabernet/amuletgpu:0.1.0'
    publishDir "${params.outdir}/amulet/antiberta2/", mode: 'copy'

    input:
    path tsv
    
    output:
    path "${tsv.baseName}_${params.mode}_antiberta2.tsv" , emit: embedding

    script:
    """
    amulet antiberta2 $tsv ${params.mode} ${tsv.baseName}_${params.mode}_antiberta2.tsv
    """
}
