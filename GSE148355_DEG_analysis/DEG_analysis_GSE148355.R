# 📦 Load Required Libraries
library(DESeq2)            # Differential expression analysis
library(WGCNA)             # For matrix operations (used in future WGCNA steps)
library(ggplot2)           # Plotting library
library(RColorBrewer)      # Color palettes for heatmaps and plots

# 📂 Define File Paths
input_path <- "C:/Users/asus/Desktop/GSE148355/"
output_path <- "C:/Users/asus/Desktop/GSE148355/results/"

# 📌 Load Raw Count Matrix
gse_file <- paste0(input_path, "GSE148355_raw_counts.csv")
GSE148355 <- read.csv(gse_file, header = TRUE, row.names = 1, stringsAsFactors = FALSE)

# 📌 Load Gene Annotation and Set Row Names
annotation_file <- paste0(input_path, "Human.GRCh38.p13.annot.csv")
GenIDGSE <- read.csv(annotation_file, header = TRUE, stringsAsFactors = FALSE)
rownames(GSE148355) <- make.unique(as.character(GenIDGSE[, 2]))

# 📌 Define Experimental Groups Based on GEO Sample IDs
totalHepatectomy <- c("GSM4462519", "GSM4462521", "GSM4462522", "GSM4462523", "GSM4462524", 
                      "GSM4462525", "GSM4462526", "GSM4462527", "GSM4462529", "GSM4462530", 
                      "GSM4462531", "GSM4462532", "GSM4462533", "GSM4462534", "GSM4462536", 
                      "GSM4462537", "GSM4462538", "GSM4462539", "GSM4462540", "GSM4462541", 
                      "GSM4462542", "GSM4462543", "GSM4462548", "GSM4462550", "GSM4462552", 
                      "GSM4462553", "GSM4462555", "GSM4462556", "GSM4462557", "GSM4462558", 
                      "GSM4462559", "GSM4462560", "GSM4462562", "GSM4462565", "GSM4462569", 
                      "GSM4462570", "GSM4462572", "GSM4462573", "GSM4462577", "GSM4462583")

NormalTissue <- c("GSM4462456", "GSM4462457", "GSM4462458", "GSM4462459", "GSM4462460",
                  "GSM4462461", "GSM4462462", "GSM4462463", "GSM4462464", "GSM4462465",
                  "GSM4462467", "GSM4462468", "GSM4462469", "GSM4462470", "GSM4462471")

# 📌 Subset Samples of Interest
Case <- which(colnames(GSE148355) %in% totalHepatectomy)
Control <- which(colnames(GSE148355) %in% NormalTissue)
selected_samples <- c(Case, Control)
mydata <- GSE148355[, selected_samples]
mydata <- mydata[, order(colnames(mydata))]  # Sort samples alphabetically
mydata <- mydata[rowSums(mydata) > 0, ]      # Remove genes with zero expression

# 📌 Filter Low-Expressed Genes
low_expression_cutoff <- quantile(rowSums(mydata), 0.10)
mydata <- mydata[rowSums(mydata) > low_expression_cutoff, ]

# 📌 Filter Low-Variance Genes
sdMydata <- apply(mydata, 1, sd)
cutoff <- quantile(sdMydata, 0.25)
mydata <- mydata[sdMydata > cutoff, ]

# 📌 Create Condition Factor and Metadata Table
conditions <- factor(c(rep("Control", length(Control)), rep("Case", length(Case))),
                     levels = c("Control", "Case"))
colData <- data.frame(row.names = colnames(mydata), condition = conditions)

# 📌 Create DESeq2 Dataset
dds <- DESeqDataSetFromMatrix(countData = mydata, 
                              colData = colData, 
                              design = ~ condition)

# 📌 Remove Genes with Low Total Count (< 10)
dds <- dds[rowSums(counts(dds)) > 10, ]

# 📌 Run DESeq2 Analysis
dds <- DESeq(dds)

# 📌 Install and Load apegLm for Shrinkage (if not already installed)
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("apeglm")

# 📌 Apply log2 Fold Change Shrinkage
res <- lfcShrink(dds, coef = "condition_Case_vs_Control", type = "apeglm")

# 📌 Save Complete Results to CSV
write.csv(as.data.frame(res), paste0(output_path, "DEGs_GSE148355.csv"))

# 📌 View Summary of DEGs
summary(res)

# 📌 Visualize MA Plot
plotMA(res, ylim = c(-5, 5))

# 📌 Filter Significant DEGs by FDR < 0.05 and |log2FC| > 1
res_sig <- res[!is.na(res$padj) & res$padj < 0.05 & abs(res$log2FoldChange) > 1, ]
write.csv(as.data.frame(res_sig), paste0(output_path,"DEGs_GSE148355_filtered.csv"))

# 📌 Volcano Plot of All Genes
library(EnhancedVolcano)
EnhancedVolcano(res,
                lab = rownames(res),
                x = 'log2FoldChange',
                y = 'padj',
                pCutoff = 0.05,
                FCcutoff = 1,
                title = 'Volcano Plot - Hepatectomy vs. Normal',
                subtitle = "Filtered by |LFC| > 1 and FDR < 0.05",
                caption = paste0("Up: ", sum(res_sig$log2FoldChange > 0), ", Down: ", sum(res_sig$log2FoldChange < 0)))

# 📌 Volcano Plot Highlighting Top 20 Genes
top_genes <- head(rownames(res_sig[order(res_sig$padj), ]), 20)
EnhancedVolcano(res,
                lab = rownames(res),
                selectLab = top_genes,
                x = 'log2FoldChange',
                y = 'padj',
                pCutoff = 0.05,
                FCcutoff = 1,
                title = 'Volcano Plot - Hepatectomy vs. Normal',
                subtitle = "Top 20 significant genes (|LFC| > 1, FDR < 0.05)",
                caption = paste0("Up: ", sum(res_sig$log2FoldChange > 0), ", Down: ", sum(res_sig$log2FoldChange < 0)),
                max.overlaps = 20,
                drawConnectors = TRUE,
                widthConnectors = 0.5)

# 📌 Extract Significant Gene Counts and Normalize for Heatmap
sig_gene_names <- rownames(res_sig)
heatmap_data <- mydata[sig_gene_names, ]
heatmap_data_log <- log2(heatmap_data + 1)

# 📌 Plot Heatmap of All Significant DEGs
install.packages("pheatmap")
library(pheatmap)
pheatmap(heatmap_data_log,
         show_rownames = FALSE,
         show_colnames = TRUE,
         cluster_cols = TRUE,
         cluster_rows = TRUE,
         color = colorRampPalette(rev(brewer.pal(n = 7, name = "RdBu")))(100),
         main = "Heatmap of Significant DEGs")

# 📌 Heatmap for Top 200 Most Significant DEGs
top200 <- rownames(res_sig[order(res_sig$padj), ])[1:200]
pheatmap(log2(mydata[top200, ] + 1),
         show_rownames = FALSE,
         show_colnames = TRUE,
         cluster_cols = TRUE,
         cluster_rows = TRUE,
         fontsize = 10,
         main = "Heatmap of Top 200 Significant DEGs",
         color = colorRampPalette(rev(RColorBrewer::brewer.pal(n = 7, name = "RdBu")))(100))



































