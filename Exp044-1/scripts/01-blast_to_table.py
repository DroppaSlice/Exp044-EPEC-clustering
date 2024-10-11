import subprocess

def blast_to_table():
    query = input("Path to query:")
    subject = input("Pat to target:")
    evalue = input("Cutoff e-value:")
    outname = input("Output file:")

    cmd1 = "blastn -query " + query + " -db " + subject + " -out " + outname + " -outfmt \"6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore\" -evalue " +  evalue
    subprocess.run(cmd1, shell = True)

blast_to_table()