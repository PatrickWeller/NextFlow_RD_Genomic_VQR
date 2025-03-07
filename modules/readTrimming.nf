/*
* Run Trimmomatic on the read fastq files
*/
process readTrimming {

	label 'process_single'

	container 'staphb/trimmomatic'

	// Add a tag to identify the process
	tag "$sample_id"

	// Specify the output directory for the trimmed read data
	publishDir("$params.outdir/trimmed_reads", mode: "copy")

    input:
	tuple val(sample_id), path(reads)

	output:
	tuple path("${sample_id}_R1_paired.fastq.gz"), path("${sample_id}_R2_paired.fastq.gz")
	//tuple path("${sample_id}_R1_unpaired.fastq.gz") path("${sample_id}_R2_unpaired.fastq.gz")

	script:
	"""
	trimmomatic PE -threads 4 ${reads[0]} ${reads[1]} \
               ${sample_id}_R1_paired.fastq.gz ${sample_id}_R1_unpaired.fastq.gz \
               ${sample_id}_R2_paired.fastq.gz ${sample_id}_R2_unpaired.fastq.gz \
               LEADING:3 TRAILING:3 SLIDINGWINDOW:4:20 MINLEN:36
	
	"""

}