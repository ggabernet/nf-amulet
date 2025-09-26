process AMULETY_BALMPAIRED{

    label (params.with_gpu? 'gpus_highmem': 'process_medium')

    container 'community.wave.seqera.io/library/amulety_igblast:659eaa872785adeb'
    publishDir "${params.outdir}/amulety/balm_paired/", mode: 'copy'

    input:
    path tsv
    
    output:
    path "${tsv.baseName}_${params.mode}_balmpaired.tsv" , emit: embedding

    script:
    """
    mkdir cache
    export TRANSFORMERS_CACHE="./cache"
    amulety balm-paired --cache-dir ./cache --cell-id-col ${params.cell_id} $tsv ${params.mode} ${tsv.baseName}_${params.mode}_balmpaired.tsv
    """
}
