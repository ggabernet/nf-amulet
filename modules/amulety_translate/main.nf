process AMULETY_TRANSLATE {
    label 'process_medium'

    container 'community.wave.seqera.io/library/igblast_curl_python_transformers_pruned:05685e2c81024d42'

    input:
    path(tsv)
    path(reference_igblast) // igblast references

    output:
    path("*_translated.tsv"), emit: translated
    path "versions.yml", emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args   = task.ext.args   ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    """
    export IGDATA=${reference_igblast}
    amulety \\
    translate-igblast \\
    --nproc ${task.cpus} \\
    $args \\
    --input-file $tsv \\
    --output-dir . \\
    --reference-dir ${reference_igblast}

    mv *_translated.tsv ${prefix}_translated.tsv

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        amulety: \$( amulety --help 2>&1 | grep -o "version [0-9\\.]\\+" | grep -o "[0-9\\.]\\+" )
        igblastn: \$( igblastn -version | grep -o "igblast[0-9\\. ]\\+" | grep -o "[0-9\\. ]\\+" )
    END_VERSIONS
    """
}
