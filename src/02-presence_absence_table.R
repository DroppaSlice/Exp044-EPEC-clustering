library(stringr)
library(seqinr)
library(dplyr)

#-----Defining the read.blast function-----#
read.blast <- function(filepath){
  x <- read.table(file = filepath,
                  col.names = c("qseqid", "sseqid", "pident", "length", "mismatch", "gapopen", "qstart", "qend", "sstart", "send", "evalue", "bitscore"))
  return(x)
}

#----running read.blast() and then performing some string manipulation to create a new accession.no variable specific to this dataset ----#
vf_df <- read.blast(filepath = "outputs/Exp044_blastResults.txt") %>% 
  mutate(accession.no = str_sub(sseqid, 8, 11)) %>%
  mutate(accession.no = as.factor(accession.no)) %>%
  mutate(qseqid = as.factor(qseqid))

#-----checking the lengths of our accession.no and qseqid variables-----#
#the numbers should match the inputs (70 for accession.no), but the qseqid length may be different if some genes were not found at all
length(levels(vf_df$accession.no))
length(levels(vf_df$qseqid))

#-----defining a new function make.pa.table() that returns a presence absence table from the normalized blast ouput tabular format-----#
#Usage:
#make.pa.table() takes up to 4 arguments. df should be a df made from the blast tabular output. x and y should be strings that point to variable names inthe data frame df and will define the x and y axes respectively in the final table
#binary is a boolean value that if true (default) will convert the table into a binary presence absence table where any number of nonzero matches will be indicated by 1
make.pa.table <- function(df, x, y, binary = T){
  table <- table(df[[x]], df[[y]])
  if(binary == T){
    table <- (table >= 1) * 1
  }
}

#-----running make.pa.table() on Exp044 blast results-----#
vf_pa <- make.pa.table(vf_df, "accession.no", "qseqid")

#-----writing out our presence absence table to an intermediate file-----#
write.csv(vf_pa, file = "outputs/Exp044_presenceAbsence.csv")