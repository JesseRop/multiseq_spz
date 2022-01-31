#!/bin/bash

##Copying entire cellranger output for "PfDB52e" mseq folder

#mseq_cellranger_source=( "5736STDY11073694" "5736STDY11073695" "5736STDY11073696" "5736STDY11073697" "5736STDY11073698" "5736STDY11073699")
mseq_cellranger_source=( "5736STDY11073694" "5736STDY11073698" "5736STDY11073699" )

mseq_libs_source=( "1" )

mseq_destination=( "nf135_nick" "nf54_nick_mix" "nf54_nick_X")

cd /lustre/scratch118/malaria/team222/jr35/phd/multiseq_spz/data/raw

for i in "${!mseq_cellranger_source[@]}";
do
	if [ ${mseq_cellranger_source[i]} == "5736STDY11073694" ]
	then

		echo ${mseq_destination[i]}/${mseq_cellranger_source[i]}_PfDB52e
		mkdir -p ${mseq_destination[i]}/${mseq_cellranger_source[i]}_PfDB52e

		iget -rf /seq/illumina/runs/41/41440/cellranger/cellranger500_count_41440_${mseq_cellranger_source[i]}_PfDB52e/. ${mseq_destination[i]}/${mseq_cellranger_source[i]}_PfDB52e/
		iget -rf /seq/illumina/runs/41/41440/lane4/plex${mseq_libs_source[i]}/41440_4\#${mseq_libs_source[i]}.cram ${mseq_destination[i]}/
	else
		echo ${mseq_destination[i]}/${mseq_cellranger_source[i]}_PfDB52e
                mkdir -p ${mseq_destination[i]}/${mseq_cellranger_source[i]}_PfDB52e

                iget -rf /seq/illumina/runs/41/41440/cellranger/cellranger500_count_41440_${mseq_cellranger_source[i]}_PfDB52e/. ${mseq_destination[i]}/${mseq_cellranger_source[i]}_PfDB52e/
	fi

done



