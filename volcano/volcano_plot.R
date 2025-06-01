# Generate a Volcano Plot from DESeq2 results with thresholds and gene labels

library(ggplot2)
library(ggrepel)  # For nice text labels

# Load DESeq2 result table
res <- read.csv("DESeq2_results.csv")

# Define statistical significance
res$significant <- "Not Significant"
res$significant[res$padj < 0.05 & abs(res$log2FoldChange) >= 1] <- "Significant"

# Label highly significant genes (optional: adjust thresholds)
res$label <- ifelse(res$padj < 0.01 & abs(res$log2FoldChange) >= 2, rownames(res), "")

# Create the plot
p <- ggplot(res, aes(x = log2FoldChange, y = -log10(padj), color = significant)) +
  geom_point(alpha = 0.7, size = 1.5) +
  scale_color_manual(values = c("grey", "red")) +
  theme_minimal() +
  labs(title = "Volcano Plot", x = "log2(Fold Change)", y = "-log10(Adjusted P-value)") +
  geom_vline(xintercept = c(-1, 1), linetype = "dashed", color = "blue") +
  geom_hline(yintercept = -log10(0.05), linetype = "dashed", color = "blue") +
  geom_text_repel(aes(label = label), size = 3, max.overlaps = 10)

# Save the plot
ggsave("volcano_plot.png", p, width = 6, height = 5)
