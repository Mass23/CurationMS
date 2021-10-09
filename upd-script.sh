linsi upd-seqs.fas > upd-aln.fa
trimal -in upd-aln.fa -out upd-trim.fa -automated1
iqtree -s upd-trim.fa -m MFP -o MDOA012067
