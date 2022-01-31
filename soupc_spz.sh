##!/bin/bash

##Submission to farm bsub -q normal -G team222 -n 16 -o /lustre/scratch118/malaria/team222/jr35/phd/multiseq_spz/data/logs/out/soupc_X_nf54_nick_spz.out -e /lustre/scratch118/malaria/team222/jr35/phd/multiseq_spz/data/logs/err/soupc_X_nf54_nick_spz.err -R "span[hosts=1] select[mem>90000] rusage[mem=90000]" -M 90000 /lustre/scratch118/malaria/team222/jr35/phd/multiseq_spz/scripts_nbooks/soupc_X_nf54_nick_spz.sh

## Variables for different folders
mseq_cellranger_source=( "5736STDY11073694" "5736STDY11073698" "5736STDY11073699" )
#mseq_cellranger_source=( "5736STDY11073694" "5736STDY11073698" )

mseq_destination=( "nf135_nick" "nf54_nick_mix" "nf54_nick_X")
#mseq_destination=( "nf135_nick" "nf54_nick_mix" )

xpctd_clusters=("2" "2" "6")
#xpctd_clusters=("2" "2")

n_cores=10

## Job submission variables
mem='-R "select[mem>90000] rusage[mem=90000]" -M 90000'

w_dir=/lustre/scratch118/malaria/team222/jr35/phd/multiseq_spz

for i in "${!mseq_destination[@]}";
do
	mkdir -p $w_dir/data/processed/${mseq_destination[i]}/${mseq_cellranger_source[i]}_PfDB52e/logs
	mkdir -p $w_dir/data/processed/${mseq_destination[i]}/${mseq_cellranger_source[i]}_PfDB52e/err
	mkdir -p $w_dir/data/processed/${mseq_destination[i]}/${mseq_cellranger_source[i]}_PfDB52e/soupc_results

	echo "#!/bin/bash" > "$w_dir/scripts_nbooks/soupc_spz_${mseq_destination[i]}.tmp.sh"
	echo "module load ISG/singularity/3.6.4" >> "$w_dir/scripts_nbooks/soupc_spz_${mseq_destination[i]}.tmp.sh"
	echo "cd $w_dir" >> "$w_dir/scripts_nbooks/soupc_spz_${mseq_destination[i]}.tmp.sh"
	echo "rm $w_dir/data/processed/${mseq_destination[i]}/${mseq_cellranger_source[i]}_PfDB52e/soupc_results/*" >> "$w_dir/scripts_nbooks/soupc_spz_${mseq_destination[i]}.tmp.sh"

	echo "singularity exec -B /lustre/scratch118/malaria/team222/jr35/ /lustre/scratch118/malaria/team222/jr35/sware/souporcell/souporcell_latest.sif souporcell_pipeline.py -i data/raw/${mseq_destination[i]}/${mseq_cellranger_source[i]}_PfDB52e/possorted_genome_bam.bam -b data/raw/${mseq_destination[i]}/${mseq_cellranger_source[i]}_PfDB52e/filtered_feature_bc_matrix/barcodes.tsv.gz -f /lustre/scratch118/malaria/team222/jr35/Pf3D7_v3.fa -t $n_cores  -o data/processed/${mseq_destination[i]}/${mseq_cellranger_source[i]}_PfDB52e/soupc_results/ -k ${xpctd_clusters[i]} -p 1"  >>  "$w_dir/scripts_nbooks/soupc_spz_${mseq_destination[i]}.tmp.sh"

	#cat(lzoom_script)
	eval $(echo "chmod a+x $w_dir/scripts_nbooks/soupc_spz_${mseq_destination[i]}.tmp.sh")
	eval $(echo "bsub -q normal -G team222 -n $n_cores -e $w_dir/data/processed/${mseq_destination[i]}/${mseq_cellranger_source[i]}_PfDB52e/err/soupo.err -o $w_dir/data/processed/${mseq_destination[i]}/${mseq_cellranger_source[i]}_PfDB52e/logs/soupo.out $mem $w_dir/scripts_nbooks/soupc_spz_${mseq_destination[i]}.tmp.sh")

done
