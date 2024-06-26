process AMULET_ESM{

    label (params.with_gpu? 'gpus_highmem': 'process_medium')

    container 'ggabernet/amuletgpu:0.1.0'
    publishDir "${params.outdir}/amulet/esm2/", mode: 'copy'

    input:
    path tsv
    
    output:
    path "${tsv.baseName}_${params.mode}_esm2.tsv" , emit: embedding

    script:
    """
    mkdir cache
    export TRANSFORMERS_CACHE="./cache"
    amulet esm2 $tsv ${params.mode} ${tsv.baseName}_${params.mode}_esm2.tsv --cache-dir ./cache --batch-size 10
    """
}
