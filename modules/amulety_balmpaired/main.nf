process AMULETY_BALMPAIRED{

    label (params.with_gpu? 'gpus': 'process_medium')

    container 'ggabernet/amuletygpu:0.1.0'
    publishDir "${params.outdir}/amulety/balm_paired/", mode: 'copy'

    input:
    path tsv
    
    output:
    path "${tsv.baseName}_${params.mode}_antiberta2.tsv" , emit: embedding

    script:
    """
    mkdir cache
    export TRANSFORMERS_CACHE="./cache"
    amulety balm-paired $tsv ${params.mode} ${tsv.baseName}_${params.mode}_balmpaired.tsv --cache-dir ./cache
    """
}
