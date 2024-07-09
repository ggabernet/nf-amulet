process AMULETY_ANTIBERTY{

    label (params.with_gpu? 'gpus': 'process_medium')

    container 'ggabernet/amuletygpu:0.1.0'
    publishDir "${params.outdir}/amulety/antiberty/", mode: 'copy'

    input:
    path tsv
    
    output:
    path "${tsv.baseName}_${params.mode}_antiberty.tsv" , emit: embedding

    script:
    """
    amulety antiberty $tsv ${params.mode} ${tsv.baseName}_${params.mode}_antiberty.tsv
    """
}
