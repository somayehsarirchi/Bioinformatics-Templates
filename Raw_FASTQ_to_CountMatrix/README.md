# Raw FASTQ to Count Matrix Pipeline

This directory contains a complete pipeline for preprocessing raw RNA-Seq data, starting from public FASTQ files (SRA) and ending with a gene-level count matrix ready for differential expression analysis.

## 🔬 Dataset
- Sample: `SRR11517955`
- Organism: *Homo sapiens*
- Source: [NCBI SRA](https://www.ncbi.nlm.nih.gov/sra)

## 🛠️ Workflow Overview

| Step | Tool         | Description                                |
|------|--------------|--------------------------------------------|
| 1    | `prefetch`   | Download raw data from SRA                 |
| 2    | `fastq-dump` | Extract FASTQ reads                        |
| 3    | `FastQC`     | Perform quality control                    |
| 4    | `Trimmomatic`| Trim adapters and low-quality bases        |
| 5    | `HISAT2`     | Align reads to the human genome (hg38)     |
| 6    | `HTSeq`      | Generate count matrix from aligned reads   |

The complete pipeline script is available in [`scripts/pipeline.sh`](./scripts/pipeline.sh).

## 📂 Output Files

Example outputs are located in `output_sample/`.  
**Note:** Due to GitHub's file size limitations, the following files are **not uploaded**:
- Trimmed FASTQ files (`SRR11517955_trimmed_1.fastq`, `SRR11517955_trimmed_2.fastq`)
- Alignment file (`SRR11517955.sam`)

These files are available upon request.

The count matrix file `SRR11517955.count` is provided for reference.

## ⚙️ Requirements

Ensure the following tools are installed and available in your `$PATH`:
- [SRA Toolkit](https://github.com/ncbi/sra-tools)
- [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)
- [Trimmomatic](http://www.usadellab.org/cms/?page=trimmomatic)
- [HISAT2](https://daehwankimlab.github.io/hisat2/)
- [HTSeq](https://htseq.readthedocs.io/)

## 📌 Notes

- The reference genome used is **GRCh38 (hg38)** pre-indexed for HISAT2, available from the [HISAT2 download page](https://daehwankimlab.github.io/hisat2/#download).
- The gene annotation file (`.gtf`) is from Ensembl [Homo_sapiens.GRCh38.109.gtf.gz](https://ftp.ensembl.org/pub/release-109/gtf/homo_sapiens/).
---

📫 For full outputs or questions, feel free to contact me.
