# volcano_plot.R
# Generate a Volcano Plot from DESeq2 results

library(ggplot2)

# Load DESeq2 result table
res <- read.csv("DESeq2_results.csv")

# Define statistical significance
res$significant <- "Not Significant"
res$significant[res$padj < 0.05 & abs(res$log2FoldChange) >= 1] <- "Significant"

# Create the plot
p <- ggplot(res, aes(x = log2FoldChange, y = -log10(padj), color = significant)) +
  geom_point(alpha = 0.7, size = 1.5) +
  scale_color_manual(values = c("grey", "red")) +
  theme_minimal() +
  labs(title = "Volcano Plot", x = "log2(Fold Change)", y = "-log10(Adjusted P-value)")

# Save the plot
ggsave("volcano_plot.png", p, width = 6, height = 5)
