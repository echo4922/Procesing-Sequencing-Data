##author: Eddie Cho##
##This Shell script is to demonstrate processing seq data. While this particular file is written in Bash shell, it may need operation directly on command line##

#!/bin/bash

#Step 1: Quality check and adapter trimming

#activate Pyton virtual env
conda activate cutadapt 

#command line argument
-a file:i5.fasta -A file:i7.fasta -o out.1.fastq.gz -p out.2.fastq.gz C3.S96.R1.fastq.gz C3.S96.R2.fastq.gz --cores=0

#Example output of paired-end Cutadapt summary shown below (printed on CLI interface of UNIX/LINUX); Output has been commented out to differentiate command line arguments  #

#This is cutadapt 4.2 with Python 3.10.8

#Processing paired-end reads on 12 cores ...
#Done           00:02:47    32,168,712 reads @   5.2 µs/read;  11.49 M reads/minute
#Finished in 167.941 s (5.221 µs/read; 11.49 M reads/minute).

#=== Summary ===

#Total read pairs processed:         32,168,712
#  Read 1 with adapter:                 819,725 (2.5%)
#  Read 2 with adapter:               1,168,021 (3.6%)
#Pairs written (passing filters):    32,168,712 (100.0%)

#Total basepairs processed: 6,479,510,641 bp
#  Read 1: 3,239,474,640 bp
#  Read 2: 3,240,036,001 bp
#Total written (filtered):  6,472,724,187 bp (99.9%)
#  Read 1: 3,236,750,691 bp
#  Read 2: 3,235,973,496 bp

#=== First read: Adapter i5 ===

#Sequence: AATGATACGGCGACCACCGAGATCTACACNNNNNNNNNNTCGTCGGCAGCGTC; Type: regular 3'; Length: 53; Trimmed: 819725 times

#No. of allowed errors:
#1-9 bp: 0; 10-19 bp: 1; 20-29 bp: 2; 30-39 bp: 3; 40-43 bp: 4

#Bases preceding removed adapters:
#  A: 32.9%
#  C: 23.3%
#  G: 19.6%
#  T: 24.3%
#  none/other: 0.0%

#Overview of removed sequences
#length	count	expect	max.err	error counts
#3	627245	502636.1	0	627245
#4	140877	125659.0	0	140877
#5	37690	31414.8	0	37690
#6	10803	7853.7	0	10803
#7	1672	1963.4	0	1672
#8	276	490.9	0	276
#9	447	122.7	0	28 419
#10	438	30.7	1	11 427
#11	212	7.7	1	2 210
#12	56	1.9	1	0 56
#13	8	0.5	1	0 8
#15	1	0.0	1	0 1


#=== Second read: Adapter i7 ===

#Sequence: CAAGCAGAAGACGGCATACGAGATNNNNNNNNNNGTCTCGTGGGCTCGG; Type: regular 3'; Length: 49; Trimmed: 1168021 times

#Minimum overlap: 3
#No. of allowed errors:
#1-9 bp: 0; 10-19 bp: 1; 20-29 bp: 2; 30-39 bp: 3

#Bases preceding removed adapters:
#  A: 27.8%
#  C: 27.0%
#  G: 23.0%
#  T: 22.2%
#  none/other: 0.0%

#Overview of removed sequences
#length	count	expect	max.err	error counts
#3	820154	502636.1	0	820154
#4	253819	125659.0	0	253819
#5	51892	31414.8	0	51892
#6	17363	7853.7	0	17363
#7	8213	1963.4	0	8213
#8	1690	490.9	0	1690
#9	2443	122.7	0	667 1776
#10	8338	30.7	1	363 7975
#11	3013	7.7	1	125 2888
#12	826	1.9	1	2 824
#13	148	0.5	1	5 143
#14	78	0.1	1	0 78
#15	31	0.0	1	0 31
#16	7	0.0	1	0 7
#17	5	0.0	1	0 5
#18	1	0.0	1	0 1



#Step 2: Mapping of the Reads
#command line argument
hisat2 test_dm6 -1 out.1.c3.s96.fastq.gz -2 out.2.c3.s96.fastq.gz  -s c3.s96.bam

#Example output of paired-end HISAT2 summary shown below (printed on CLI interface of UNIX/LINUX); Output has been commented out to differentiate command line arguments  #

#32168712 reads; of these:
#  32168712 (100.00%) were paired; of these:
#    2989390 (9.29%) aligned concordantly 0 times
#    28464622 (88.49%) aligned concordantly exactly 1 time
#    714700 (2.22%) aligned concordantly >1 times
#    ----
#    2989390 pairs aligned concordantly 0 times; of these:
#      1077902 (36.06%) aligned discordantly 1 time
#    ----
#    1911488 pairs aligned 0 times concordantly or discordantly; of these:
#      3822976 mates make up the pairs; of these:
#        1987100 (51.98%) aligned 0 times
#        1738862 (45.48%) aligned exactly 1 time
#        97014 (2.54%) aligned >1 times
#96.91% overall alignment rate


#Step 3: Summarization of Reads
#command line argument

#activate Pyton virtual env
conda activate featurecounts 

#command line argument
featureCounts -p -T12 -a  dmel-all-r6.32.gtf -o cr_C3_S96.tabular 1_WT_C3_S96.bam -s2 --countReadPairs 

#Example output of featurecounts summary shown below (printed on CLI interface of UNIX/LINUX); Output has been commented out to differentiate command line arguments  #

#//========================== featureCounts setting ===========================\\
#||                                                                            ||
#||             Input files : 1 BAM file                                       ||
#||                                                                            ||
#||                           1_WT_C3_S96.bam                                  ||
#||                                                                            ||
#||             Output file : cr_C3_S96.tabular                                ||
#||                 Summary : cr_C3_S96.tabular.summary                        ||
#||              Paired-end : yes                                              ||
#||        Count read pairs : yes                                              ||
#||              Annotation : dmel-all-r6.32.gtf (GTF)                         ||
#||      Dir for temp files : ./                                               ||
#||                                                                            ||
#||                 Threads : 12                                               ||
#||                   Level : meta-feature level                               ||
#||      Multimapping reads : not counted                                      ||
#|| Multi-overlapping reads : not counted                                      ||
#||   Min overlapping bases : 1                                                ||
#||                                                                            ||
#\\============================================================================//

#//================================= Running ==================================\\
#||                                                                            ||
#|| Load annotation file dmel-all-r6.32.gtf ...                                ||
#||    Features : 189205                                                       ||
#||    Meta-features : 17606                                                   ||
#||    Chromosomes/contigs : 25                                                ||
#||                                                                            ||
#|| Process BAM file 1_WT_C3_S96.bam...                                        ||
#||    Strand specific : reversely stranded                                    ||
#||    Paired-end reads are included.                                          ||
#||    Total alignments : 34696425                                             ||
#||    Successfully assigned alignments : 26070151 (75.1%)                     ||
#||    Running time : 0.19 minutes                                             ||
#||                                                                            ||
#|| Write the final count table.                                               ||
#|| Write the read assignment summary.                                         ||
#||                                                                            ||
#|| Summary of counting results can be found in file "cr_C3_S96.tabular.summa  ||
#|| ry"                                                                        ||
#||                                                                            ||
#\\============================================================================//


