# LMWgsFinder

**`LMWgsFinder`** is a Perl script package (v5.26.2, built for x86_64-linux-thread-multi) designed to identify LMW-GS genes in the genomes of various wheat cultivars and related species, and to obtain related sequences and information. LMWgsFinder contains 34 Perl scripts and one Linux shell script, and requires the use of ncbi-blast-2.14.0+ and Linux system commands such as “cat”, “dos2unix”, “sed”,  etc to run properly.

The usage of LMWgsFinder is extremely simple. Simply place the genome sequence file, the corresponding CDS file and protein sequence file in the same directory with this package, and then run a main script： 
```
perl LMWgsFinder.v5.pl testDNAtoplevel.fa Tatest testCDS.fasta testPro.fasta
```
If there are nearly 20 result files generated in the folder named 'results', it indicates that the package is running correctly. These result files can be used for sequence analysis and experimental validation of LMW-GS genes.

Genomic sequence files, CDS sequence files, and protein sequence files must all be in Fasta format. The extension of the genome sequence file needs to be ".fa", while, the file extension of CDS and Pro needs to be '.fasta'. 
