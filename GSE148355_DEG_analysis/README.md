<p align="center">
  <img src="https://img.shields.io/badge/license-CC%20BY%204.0-lightgrey.svg" alt="License: CC BY 4.0">
  <img src="https://img.shields.io/badge/language-R-blue" alt="Language: R">
</p>

# Combining WGCNA and DEG Analysis with Prioritization of Enrichment Results for Kidney Allograft Biomarkers

## Introduction

This repository provides a comprehensive workflow for integrating Weighted Gene Co-expression Network Analysis (WGCNA) and Differential Expression Analysis (DEGs), followed by prioritization of enrichment results. The goal is to identify biologically meaningful hub genes and key biomarkers involved in chronic kidney allograft rejection.

## Project Workflow

- **WGCNA Analysis**: Construct gene co-expression networks, detect and merge modules.
- **DEG Analysis**: Identify differentially expressed genes between control and rejection samples.
- **Intersection Analysis**: Extract overlapping genes between WGCNA modules and DEGs.
- **Hub Gene Selection**: Rank hub genes based on network centrality metrics.
- **Prioritization of Enrichment Results**: Filter pathways, GO terms, and diseases based on hub gene involvement and statistical significance.
- **Visualization**: Create bubble plots and disease-gene networks for the final results.

---

## Repository Structure

```
WGCNA_DEGs_validation/
├── code/
│   ├── 01_WGCNA_Analysis.R
│   ├── 02_DEGs_Analysis.R
│   ├── 03_Intersect_Analysis.R
│   ├── 04_Select_TopHubGenes_Gephi.R
│   ├── 05_Select_SharedHubGenes.R
│   ├── 06_Pathways_Filtering.R
│   ├── 07_GO_Filtering.R
│   ├── 08_Disease_Filtering.R
│   └── 09_BubblePlots.R
│
├── data/
│   ├── GSE192444_series_matrix.csv
│   ├── GSE192444Groups.csv
│   ├── familySoft_mini.csv
│   ├── GSE261892_raw_counts_GRCh38.p13_NCBI.csv
│   └── GSE261892DEGs.csv
│
├── results/
│   ├── WGCNA/
│   │   └── [Module gene lists, intermediate WGCNA results]
│   ├── Plots/
│   │   └── [Final visualizations: bubble plots, disease-gene networks]
│   ├── Filtered_Enriched_Pathways.csv
│   ├── Filtered_Enriched_GO.csv
│   ├── Filtered_Enriched_Diseases.csv
│   └── [Other processed and filtered results]
│
├── README.md
└── LICENSE
```

---

## How to Use

1. **Clone the repository**:

   ```bash
   git clone https://github.com/somayehsarirchi/WGCNA_DEGs_validation.git
   ```

2. **Set up your environment**:
   - Install R (version 4.0 or higher) and RStudio.

3. **Install the required R packages**:

   ```r
   install.packages(c("WGCNA", "limma", "DESeq2", "ggplot2", "igraph", "reshape2"))
   ```

4. **Run the scripts sequentially**:
   - Start with `01_WGCNA_Analysis.R`, then continue through to `09_BubblePlots.R`.

5. **Review your results**:
   - Outputs will be saved in the `results/` folder, organized by analysis type.

---

## Data Sources

- [GSE192444 - Peripheral blood and Biopsy samples](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE192444)
- [GSE261892 - Biopsy samples](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE261892)

## License

This project is licensed under the [Creative Commons Attribution 4.0 International License (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/).

## Citation

If you use this repository, please cite it as:

> Sarirchi, S. (2025). *Combining WGCNA and DEG Analysis with Prioritization of Enrichment Results for Kidney Allograft Biomarkers*. GitHub repository. [https://github.com/somayehsarirchi/WGCNA_DEGs_validation](https://github.com/somayehsarirchi/WGCNA_DEGs_validation)
