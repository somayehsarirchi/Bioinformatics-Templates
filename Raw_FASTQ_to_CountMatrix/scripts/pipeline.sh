#!/bin/bash

# 📥 Step 1: Download data from SRA
prefetch -p SRR11517955

# 📦 Step 2: Convert SRA to FASTQ
fastq-dump --split-3 SRR11517955

# 🧪 Step 3: Quality Control
fastqc -f fastq SRR11517955_1.fastq SRR11517955_2.fastq

# ✂️ Step 4: Trimming using Trimmomatic
java -jar Trimmomatic-0.39.jar PE \
  SRR11517955_1.fastq SRR11517955_2.fastq \
  SRR11517955_trimmed_1.fastq SRR11517955_untrimmed_1.fastq \
  SRR11517955_trimmed_2.fastq SRR11517955_untrimmed_2.fastq \
  LEADING:25 TRAILING:25 SLIDINGWINDOW:4:20 MINLEN:50

# 🧬 Step 5: Align to reference genome using HISAT2
hisat2 -q -p 8 --add-chrname -x /path/to/hg38/genome \
  --rg ID:115 --rg SM:SRR11517955 --rg PL:ILUMINA \
  -1 SRR11517955_trimmed_1.fastq \
  -2 SRR11517955_trimmed_2.fastq \
  -S SRR11517955.sam

# 📊 Step 6: Count reads using HTSeq
htseq-count SRR11517955.sam /path/to/hg38_whole.gtf > SRR11517955.count

