process UNZIP_DB {
    tag "unzip_db"
    label 'process_medium'

    conda "conda-forge::sed=4.7"
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://containers.biocontainers.pro/s3/SingImgsRepo/biocontainers/v1.2.0_cv1/biocontainers_v1.2.0_cv1.img' :
        'docker.io/biocontainers/biocontainers:v1.2.0_cv1' }"

    input:
    path(archive)

    output:
    path("$unzipped")   , emit: unzipped
    tuple val("${task.process}"), val('unzip'), eval('unzip -v 2>&1 | head -n 1 | sed \'s/^.*UnZip //; s/ of.*$//\''), emit: versions_unzip, topic: versions

    script:
    unzipped = archive.toString() - '.zip'
    """
    unzip $archive

    """
}