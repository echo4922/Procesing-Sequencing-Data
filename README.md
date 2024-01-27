# Procesing-Sequencing-Data

Processing Next-Generation sequencing data is one of the most important tasks, yet it could be one of the most daunting tasks at the same time. For my master’s thesis, I have had an outstanding lab mate who helped me to develop the pipeline. Here, the processing means using compressed sequencing data sets to human readable format often using command line arguments on UNIX/LINUX operating systems. Results are comma separated value (.csv) files that can be opened in spreadsheet editor like Microsoft Excel.  Based on experience on processing various sequencing data sets, UNIX/LINUX operating system is recommended to process NGS data sets. Historically, bioinformatics analysis tools have been developed and optimized in UNIX/LINUX operating systems. As a Microsoft Windows user, I have found that installation and operation on UNIX/LINUX on Windows via Windows Subsystem for Linux (WSL) did not yield the most efficient way to work with sequencing data though I have to say the overall experience was better than installing and operating UNIX/LINUX on Windows Virtual box as it seems to take lots  of random access memories (RAM).  Nowadays, most research focused universities have high performance scientific computing center/infrastructure. For my master’s thesis, I set up my own system to understand better about how a computer works. Therefore, I purchased a mini desktop computer then installed Debian based UNIX/LINUX, Ubuntu 22.04 “Jammy Jellyfish” on an empty solid-state drives (SSD). Not surprisingly, user experience has been far superior to process sequencing data sets.


![Pipeline](https://github.com/echo4922/Procesing-Sequencing-Data/assets/112420424/b589a18c-70e2-44ac-80ba-4064a0e4350b)


## First Step of Processing NGS Sequencing Data: Quality Verification and Adapter Sequence Trimming
In the figure, raw reads refer to "Next-generation sequencing (NGS) read length refers to the number of base pairs (bp) sequenced from a DNA fragment" (Source: Illumina). Therefore, raw reads refer to the unprocessed and compressed sequencing data (often .gz format) downloaded from a sequencing process facility. Given data sets for my thesis was bulk RNA-Seq, it was pair ended. To process sequencing data for my thesis, the first step was to verify quality and trimming of adapter sequences. The paired-end Illumina reads were first processed with Trim Galore, a wrapper tool that invokes existing software including Cutadapt and FastQC. As such, Cutadapt and FastQC need to be installed first before using Trim Galore. FastQC is a quality assessment Bioinformatics software for sequencing files while Cutadapt is an adapter sequence trimming Bioinformatics software. With Trim Galore, the quality assessment of reads (FastQC) and the trimming process (Cutadapt) are performed with one line of command. The input parameters for Trim Galore include the autodetection of adapter sequence, the default quality Phred score cutoff (20), default encoding type (ASCII+33), default maximum trimming error rate (0.1), default minimum required adapter overlap stringency (1 bp), and default minimum required sequence length for both reads before removed sequence pair (20 bp) for the trimming.

## Second Step of Processing NGS Sequencing Data: Mapping of the Reads




References:
https://www.illumina.com/science/technology/next-generation-sequencing/plan-experiments/read-length.html








