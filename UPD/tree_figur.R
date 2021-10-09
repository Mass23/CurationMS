setwd('/Users/admin/Documents/Academia/Curation manuscript')
library(ggtree)
library(seqinr)
library(ggplot2)
library(ggpubr)
library(patchwork)

tree <- read.tree(file="upd-trim.fa.treefile")
p = msaplot(p=ggtree(tree), fasta="upd-aln.fa", offset = 2) + geom_tiplab(align=TRUE) + guides(fill = FALSE) + geom_hilight(node = 34, fill="steelblue")

aln = read.alignment("upd-aln.fa",format = 'fasta')
sequences = aln$nam
seq_len = nchar(aln$seq[[1]])

fixed_changes = c()
for (nuc in c(1:seq_len)){
  # get amino acids counts
  others_vec = c()
  mosquito_vec = c()
  for (seq in 1:30){
    seq_vec = strsplit(aln$seq[[seq]],'')[[1]]
    if (seq < 16){mosquito_vec = c(mosquito_vec, seq_vec[nuc])}
   else{others_vec = c(others_vec, seq_vec[nuc])}}
  # divergence = 
  mos_identity = c(mos_identity, table(mosquito_vec)[table(mosquito_vec) == max(table(mosquito_vec))] / 15)
  # if there's only one amino acid in mosquitoes, and the amino acid is not found in others
  if ((length(names(table(mosquito_vec))) == 1) & (length(intersect(names(table(mosquito_vec))[1],names(table(others_vec))))==0)){
    fixed_changes = c(fixed_changes, nuc)
    print(paste0('Position: ',nuc))
    print(table(mosquito_vec))
    print(table(others_vec))}}

p2 = ggplot(conservation_df) + geom_line(aes(x=Position,y=Identity), color = 'steelblue') + theme_bw() + ylab('Identity') + xlab('') + 
  theme(legend.position = "top", legend.box = "vertical")
for (nuc in fixed_changes){
  p2 = p2 + geom_vline(xintercept = nuc, color='darkred')}

p
ggsave('Aln_figure.pdf',width=7,height=6)
ggsave('Aln_figure.png',width=7,height=6)
