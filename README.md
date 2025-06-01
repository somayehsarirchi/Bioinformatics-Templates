
# Bioinformatics Analysis Templates

This repository contains modular R scripts and example datasets for common bioinformatics tasks, including bulk RNA-Seq differential expression (DESeq2), variant filtering from WES VCF files, heatmap generation, and volcano plot visualization. Each folder contains necessary scripts, inputs, and representative outputs.

> ⚠️ All data included are for demonstration only.

---

## Folder Structure

```
Bioinformatics-Templates/
├── README.md
├── demo_analysis.Rmd
├── deseq2/
│   ├── DESeq2_pipeline.R
│   ├── DESeq2_results.csv
│   ├── example_counts.txt
│   └── example_metadata.csv
├── heatmap/
│   ├── Heatmap_Template.R
│   ├── heatmap.png
│   └── normalized_counts.csv
├── vcf_filtering/
│   ├── VCF_Filtering.R
│   ├── myvcf.vcf
│   └── vcf_filtered.csv
└── volcano/
    ├── volcano_plot.R
    ├── volcano_plot.png
    └── expression_matrix.csv
```

---

## Scripts Overview

| Script Name           | Description                                                                 |
|----------------------|-----------------------------------------------------------------------------|
| DESeq2_pipeline.R     | Normalizes RNA-Seq count data and identifies differentially expressed genes |
| Heatmap_Template.R    | Draws a heatmap of selected or all genes using scaled expression data       |
| VCF_Filtering.R       | Parses and filters VCF data based on quality, depth, and other metrics      |
| volcano_plot.R        | Generates a volcano plot from DESeq2 results                               |

---

## Sample Data

| File                  | Description                                        |
|-----------------------|----------------------------------------------------|
| example_counts.txt     | Simulated count matrix (genes × samples)          |
| example_metadata.csv   | Sample group labels (Control / Case)              |
| expression_matrix.csv  | Matrix for visualization (heatmap, volcano)       |
| myvcf.vcf              | Sample VCF file (simplified for demo)             |
| vcf_filtered.csv       | Filtered variant calls after quality control      |

---

## How to Use

1. **Clone the repository:**
```bash
git clone https://github.com/somayehsarirchi/Bioinformatics-Templates.git
cd Bioinformatics-Templates
```

2. **Navigate to a specific folder** (e.g. `deseq2/`, `vcf_filtering/`)

3. **Run the corresponding script** in R or RStudio:
```r
source("DESeq2_pipeline.R")
```

4. **Render demo notebook:**
Open `demo_analysis.Rmd` in RStudio and click **Knit** to generate a combined HTML report.

---

## Requirements

- R version ≥ 4.2
- Required packages: `DESeq2`, `ggplot2`, `pheatmap`, `readr`, `dplyr`, `Hmisc`, `enrichR`, etc.
- All scripts include package calls and error handling.

---

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## Author
**Somayeh Sarirchi**  
Bioinformatics Scientist  
📧 [s.sarirchi@gmail.com](mailto:s.sarirchi@gmail.com)  
🔗 [GitHub Profile](https://github.com/somayehsarirchi)
