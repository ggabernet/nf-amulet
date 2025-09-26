process AMULETY_TRANSLATE {
    label 'process_single'

    container 'quay.io/biocontainers/mulled-v2-92ebbfc09fc136b8e201cb187cd9567ba335d439:459e6ebe51fb2818cb6de807f2c5fa99599b1214-0'

    input:
    path(tsv)
    path(reference_igblast) // igblast references

    output:
    path("*_translated.tsv") , emit: translated
    path "versions.yml" , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    """
    export IGDATA=${reference_igblast}
    amulety translate-igblast $tsv . ${reference_igblast}

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        amulety: \$( amulety --help 2>&1 | grep -o "version [0-9\\.]\\+" | grep -o "[0-9\\.]\\+" )
        igblastn: \$( igblastn -version | grep -o "igblast[0-9\\. ]\\+" | grep -o "[0-9\\. ]\\+" )
    END_VERSIONS
    """
}
