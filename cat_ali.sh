
fasta_dir=$1
name=$2

cat $1/*fa > $2.fa

cdhit -i $2.fa -o $2_ed1.fa -c 1.00 -n 5

mafft --auto $2_ed1.fa > $2_ed2.fa

mkdir $1/rax

mv *.fa $1/rax

rm *.clstr
