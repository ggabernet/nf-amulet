process AMULETY_ANTIBERTA{

    label (params.with_gpu? 'gpus': 'process_medium')

    container 'community.wave.seqera.io/library/amulety_igblast:659eaa872785adeb'
    publishDir "${params.outdir}/amulety/antiberta2/", mode: 'copy'

    input:
    path tsv
    
    output:
    path "${tsv.baseName}_${params.mode}_antiberta2.tsv" , emit: embedding

    script:
    """
    mkdir cache
    export TRANSFORMERS_CACHE="./cache"
    amulety antiberta2 --cell-id-col ${params.cell_id} --cache-dir ./cache $tsv ${params.mode} ${tsv.baseName}_${params.mode}_antiberta2.tsv 
    """
}
