import subprocess
import sys

#The purpose of this script is to interactively run a nucleotide blast search using python

def blast_to_table():
    if len(sys.argv) > 2: 
        query = sys.argv[1]
        subject = sys.argv[2]
        outname = sys.argv[3]
        evalue = sys.argv[4]
    elif len(sys.argv) <2:
        query = input("Path to query:")
        subject = input("Path to subject:")
        outname = input("Output file:")
        evalue = input("Cutoff e-value:")

    cmd1 = "/Users/zhudx/ncbi-blast/bin/blastn -query " + query + " -db " + subject + " -out " + outname + " -outfmt \"6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore\" -evalue " +  evalue
    subprocess.run(cmd1, shell = True)

blast_to_table()