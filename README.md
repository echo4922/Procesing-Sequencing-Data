# Procesing-Sequencing-Data

Processing Next-Generation sequencing data is one of the most important tasks, yet it could be one of the most daunting tasks at the same time. For my master’s thesis, I have had an outstanding lab mate who helped me to develop the pipeline. Here, the processing means using compressed sequencing data sets to human readable format often using command line arguments on UNIX/LINUX operating systems. Results are comma separated value (.csv) files that can be opened in spreadsheet editor like Microsoft Excel.  Based on experience on processing various sequencing data sets, UNIX/LINUX operating system is recommended to process NGS data sets. Historically, bioinformatics analysis tools have been developed and optimized in UNIX/LINUX operating systems. As a Microsoft Windows user, I have found that installation and operation on UNIX/LINUX on Windows via Windows Subsystem for Linux (WSL) did not yield the most efficient way to work with sequencing data though I have to say the overall experience was better than installing and operating UNIX/LINUX on Windows Virtual box as it seems to take lots  of random access memories (RAM).  Nowadays, most research focused universities have high performance scientific computing center/infrastructure. For my master’s thesis, I set up my own system to understand better about how a computer works. Therefore, I purchased a mini desktop computer then installed Debian based UNIX/LINUX, Ubuntu 22.04 “Jammy Jellyfish” on an empty solid-state drives (SSD). Not surprisingly, user experience has been far superior to process sequencing data sets.


![Pipeline](https://github.com/echo4922/Procesing-Sequencing-Data/assets/112420424/b589a18c-70e2-44ac-80ba-4064a0e4350b)


## First Step of Processing NGS Sequencing Data: Quality Verification and Adapter Sequence Trimming
In the figure, raw reads refer to "Next-generation sequencing (NGS) read length refers to the number of base pairs (bp) sequenced from a DNA fragment" (Source: Illumina). Therefore, raw reads refer to the unprocessed and compressed sequencing data (often .gz format) downloaded from a sequencing process facility. Given data sets for my thesis was bulk RNA-Seq, it was pair ended. To process sequencing data for my thesis, the first step was to verify quality and trimming of adapter sequences. The paired-end Illumina reads were first processed with Trim Galore, a wrapper tool that invokes existing software including Cutadapt and FastQC. As such, Cutadapt and FastQC need to be installed first before using Trim Galore. FastQC is a quality assessment Bioinformatics software for sequencing files while Cutadapt is an adapter sequence trimming Bioinformatics software. With Trim Galore, the quality assessment of reads (FastQC) and the trimming process (Cutadapt) are performed with one line of command. The input parameters for Trim Galore include the autodetection of adapter sequence, the default quality Phred score cutoff (20), default encoding type (ASCII+33), default maximum trimming error rate (0.1), default minimum required adapter overlap stringency (1 bp), and default minimum required sequence length for both reads before removed sequence pair (20 bp) for the trimming.

Sequence alignment is an important process to compare nucleotide or amino acid sequences in bioinformatics. By vertically arranging sequences, regions of similarity are compared and then identified to understand functional, structural, and/or evolutionary relationships between the sequences. The two most utilized methods of sequence alignment are global alignment and local alignment. In the global alignment, the entire length of two sequences is aligned. It is often used when two sequences have the same length. In addition, all differences are counted as well in the global alignment (Source: Microbenotes.com). A well-known example of global alignment in the context of Bioinformatics is the Needleman-Wunsch algorithm. Conversely, the local alignment aligns sequences such that only regions with the highest overlapping of matches are aligned (Source: Microbenotes.com). The Smith–Waterman algorithm uses the local alignment. Both global and local alignments use a scoring matrix to quantify the similarity of sequences. 

Cutadapt makes use of a modified version of global alignment as an adapter trimming algorithm: semi-global alignment. In Cutadapt, the semi-global alignment does not penalize initial and/or trailing gaps and it gives sequences freedom to shift and differences are penalized only if there is an overlapping region between them (Source: Original paper by Martin & Cutadapt manual). In a conventional alignment scoring system, a positive value is given for matches and a negative value is given for mismatches and indels (insertions and deletions). In Cutadapt, the scoring system uses “unit costs” where mismatches, insertions, and deletions are counted as one error. According to the manual of Cutadapt, this allows an easy implementation of the algorithm because a single parameter (maximum error rate) can be used for counting errors. However, using unit costs to replace the scoring system in the alignment process has its limitations; optimal alignment occurs where total costs are minimized. This alignment based on the unit costs would lead to no overlapping of sequences and adapter sequences would not be identified. The algorithm of the Cutadapt has been refined such that it considers maximum overlap between the two sequences with the condition that the allowed error rate is not exceeded. The adapter alignment algorithm of Cutadapt is a five-step process (Source: Original paper by Martin & Cutadapt manual). First, all possible overlaps between two sequences are considered and the alignment is computed to minimize the total number of errors in each one. Second, possible alignments that do not exceed the specified maximum error rate are kept. Third, only the alignments with a maximum number of matches are kept. Fourth, in case multiple alignments exist with the same number of matches, only the alignments with the smallest error rate are kept. Lastly, if there are multiple alignment candidates, then the alignment, which starts at the leftmost position within the read, is chosen. The trimming algorithm in Cutadapt is based on Burrows-Wheeler Transformation (BWT). The BWT is an algorithm that arranges data, often text character strings, such that similar characters are grouped together. Once transformed, the results have the same text character strings arranged in different orders. In other words, the algorithm arranges similar characters next to each other making data compression easier (Source: Technopedia.com). Inversing BWT is a process of recovering original character strings. Cutadapt makes use of inversing BWT and it is executed in three steps. First, the subtraction of the input cutoff from all possible qualities is performed. Second, partial sums from all indices to the end of the sequence are computed. Lastly, the sequence at the index where the sum is minimal is trimmed (Source: Original paper by Martin & Cutadapt manual).




## Second Step of Processing NGS Sequencing Data: Mapping of the Reads

In RNA-Seq analysis, if a reference genome is available for an organism, then the data analysis is usually performed where short sequencing reads are mapped against an annotated reference genome and this is known as genome mapping (Paper by Conesa et al., 2016). The reference genome is a scientifically accepted genome sequence as a standard to compare sequences of interest for a specific organism (Wetterstrand, 2023). As Drosophila melanogaster is one of the widely studied model organisms, the reference genome sequence has been available since 2000.


References: <br />
Illumina NGS: https://www.illumina.com/science/technology/next-generation-sequencing/plan-experiments/read-length.html <br />
Local & Global Alignments: https://microbenotes.com/local-global-multiple-sequence-alignment <br />
Burrows Wheeler Transformation: https://www.techopedia.com/definition/10467/burrows-wheeler-transform-bwt <br />
Cutadapt: https://doi.org/10.14806/ej.17.1.200 (Original paper by Martin), https://cutadapt.readthedocs.io/en/stable/algorithms.html (Cutadapt online manual documentation) <br />
Paper by Conesa et al., 2016: https://doi.org/10.1186/s13059-016-0881-8






