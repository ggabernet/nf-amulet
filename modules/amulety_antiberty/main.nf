process AMULETY_ANTIBERTY{

    label (params.with_gpu? 'gpus': 'process_medium')

    container 'community.wave.seqera.io/library/amulety_igblast:659eaa872785adeb'
    publishDir "${params.outdir}/amulety/antiberty/", mode: 'copy'

    input:
    path tsv
    
    output:
    path "${tsv.baseName}_${params.mode}_antiberty.tsv" , emit: embedding

    script:
    """
    amulety antiberty --cell-id-col ${params.cell_id} $tsv ${params.mode} ${tsv.baseName}_${params.mode}_antiberty.tsv
    """
}
