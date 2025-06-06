# Raw FASTQ to Count Matrix Pipeline

This pipeline demonstrates the complete preprocessing of raw RNA-Seq data from the SRA database to a count matrix ready for downstream differential expression analysis.

## 🔬 Dataset
- Sample: `SRR11517955`
- Organism: Human (Homo sapiens)
- Source: NCBI SRA

## 🛠️ Steps
1. **Download** sample using `prefetch`
2. **FASTQ extraction** with `fastq-dump`
3. **Quality Control** via `FastQC`
4. **Trimming** using `Trimmomatic` (Phred33 encoding, strict filtering)
5. **Alignment** to `hg38` reference genome using `HISAT2`
6. **Quantification** with `HTSeq-count` using comprehensive `GTF` annotation

## 📂 Folder Structure
- `scripts/`: Contains the full bash script of the workflow
- `output_sample/`: Example outputs (trimmed reads, SAM, count file)
- `reference/`: Genome and annotation info (index info, GTF)

## ⚠️ Note
Please ensure that:
- SRA Toolkit, FastQC, Trimmomatic, HISAT2, and HTSeq are installed
- Proper path to genome index and GTF is specified in `pipeline.sh`

---

🧪 For downstream steps like DESeq2 or WGCNA, see other folders in this repository.

