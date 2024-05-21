process AMULET_ESM{

    label (params.with_gpu? 'gpus': 'process_medium')

    container 'ggabernet/amuletgpu:0.1.0'
    publishDir "${params.outdir}/amulet/esm2/", mode: 'copy'

    input:
    path tsv
    
    output:
    path "${tsv.baseName}_${params.mode}_esm2.tsv" , emit: embedding

    script:
    """
    mkdir cache
    amulet esm2 $tsv ${params.mode} ${tsv.baseName}_${params.mode}_esm2.tsv --cachedir ./cache
    """
}
