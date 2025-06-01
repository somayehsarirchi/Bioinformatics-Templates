# Heatmap Template for Gene Expression Matrix
library(pheatmap)

# Load expression matrix (genes as rows, samples as columns)
expr <- read.csv("expression_matrix.csv", row.names=1)

# Optional: scale data
expr_scaled <- t(scale(t(expr)))

# Plot
pheatmap(expr_scaled, 
         clustering_distance_rows = "euclidean",
         clustering_distance_cols = "euclidean",
         show_rownames = FALSE,
         show_colnames = TRUE,
         main = "Gene Expression Heatmap")
