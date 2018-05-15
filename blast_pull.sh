fasta_query=$1
outfile=$2

for fasta in ./Geneome_db/*.fa
do
        echo "BLASTING  $fasta ..."
        blastp -query $1 -db $fasta -out ${fasta%.}_ref_blastout -outfmt 6 -max_target_seqs 10 -evalue 0.0001
done

mkdir temp

mv ./Geneome_db//*blastout temp

for i in temp/*blastout
do
  echo "getting hit accessions  $i ..."
  cut -f2 $i > ${i%.}_hits
done

mkdir temp2

mv temp/*hits temp2

for hitfile in temp2/*_ref_blastout_hits

do
perl -p -e 's/\>//g' $hitfile > temp_file
filenamefull=${hitfile##*/}
#echo $filenamefull
filename="${filenamefull%_ref_blastout_hits*}"
echo "pull FASTA seqs from  $filename ..."
selectSeqs.pl -f temp_file ./Geneome_db/$filename >> $filename
rm temp_file
done

mkdir $2_fastas

mv *.fa $2_fastas

rm -r temp*
