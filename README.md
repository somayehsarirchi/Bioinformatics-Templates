# 🔬 Bioinformatics Analysis Templates

This repository contains modular and reusable R and Bash scripts for analyzing bulk RNA-Seq and variant call data (WES). It is intended to demonstrate practical, real-world pipelines that are well-documented and reproducible.

⚠️ **Note**: All data included here are simulated and for demonstration purposes only.

---

## 📁 Repository Structure

Bioinformatics-Templates/
├── README.md
├── scripts/
│ ├── DESeq2_pipeline.R
│ ├── VolcanoPlot.R
│ ├── Heatmap_Template.R
│ └── VCF_Filtering.R
├── data/
│ ├── example_counts.txt
│ └── example_metadata.csv
└── results/
└── demo_volcano_plot.png # optional



## 🧬 Included Scripts

| Script | Purpose |
|--------|---------|
| `DESeq2_pipeline.R` | Normalizes RNA-Seq count data and identifies DEGs |
| `VolcanoPlot.R` | Visualizes DEGs as a volcano plot |
| `Heatmap_Template.R` | Generates a heatmap of selected genes |
| `VCF_Filtering.R` | Parses and filters VCF files from GATK based on common QC metrics (QD, FS, SOR, GQ, DP) |

---

## 📊 Sample Data

| File | Description |
|------|-------------|
| `example_counts.txt` | Simulated gene expression count matrix (100 genes × 6 samples) |
| `example_metadata.csv` | Group information (Control vs Case) for the 6 samples |

---

## ▶️ How to Use

1. Clone the repository:
   ```bash
   git clone https://github.com/somayehsarirchi/Bioinformatics-Templates.git
   cd Bioinformatics-Templates
Open and run the scripts inside the scripts/ folder:

Make sure the required R packages (DESeq2, ggplot2, etc.) are installed.

Modify input file paths as needed.

Use the data/ folder as an example input or replace it with your own data in the same format.

🔗 About
These scripts are part of my academic and freelance bioinformatics work. I regularly work with RNA-Seq, WES, and scRNA-seq datasets using tools such as DESeq2, HISAT2, GATK, Seurat, and custom Bash workflows.

If you're interested in custom pipelines or scientific collaboration, feel free to contact me.

Somayeh Sarirchi
Bioinformatics Scientist
📧 s.sarirchi@gmail.com
