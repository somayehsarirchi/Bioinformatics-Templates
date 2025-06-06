# 📦 1. Load required libraries
library(WGCNA)
options(stringsAsFactors = FALSE)

# 📥 2. Read raw count data
mydata <- read.csv("Client Inputs/GSE148355_raw_counts.csv", header = TRUE)
rownames(mydata) <- as.character(mydata[,1])
mydata <- mydata[,-1]
mydata <- as.matrix(mydata)

# 📋 3. Read trait metadata
Class <- read.csv("Client Inputs/traits.csv", header = TRUE)
Class$Population <- as.factor(Class$Population)
Class$Gender <- as.factor(Class$Gender)
Class$Age <- as.numeric(Class$Age)
Class$SampleNames <- trimws(Class$SampleNames)
Class$SampleNames <- gsub("[[:space:]]", "", Class$SampleNames)

# 🎯 4. Synchronize samples
common_samples <- intersect(Class$SampleNames, colnames(mydata))
mydata <- mydata[, common_samples]
Class <- Class[Class$SampleNames %in% common_samples, ]
Class <- Class[match(common_samples, Class$SampleNames), ]
stopifnot(identical(colnames(mydata), Class$SampleNames))

# 🧬 5. Filter top 5000 variable genes
gene_vars <- apply(mydata, 1, var)
top_genes <- order(gene_vars, decreasing = TRUE)[1:5000]
filteredData <- mydata[top_genes, ]
mydata2 <- t(filteredData)

# ⚙️ 6. Determine soft-thresholding power
mySoft <- pickSoftThreshold(mydata2, powerVector = 1:20)
selected_power <- which(mySoft$fitIndices$SFT.R.sq >= 0.9)[1]

# 📈 7. Save diagnostic plots
dir.create("Expected Output/Figures", showWarnings = FALSE)

pdf("Expected Output/Figures/Scale_Independence.pdf")
plot(mySoft$fitIndices$Power, -sign(mySoft$fitIndices$slope)*mySoft$fitIndices$SFT.R.sq,
     xlab = "Soft Threshold (Power)", ylab = "Scale-Free Topology Fit Index", 
     main = "Scale Independence", type = "b", pch = 19, col = "blue")
abline(h = 0.9, col = "red", lty = 2)
dev.off()

pdf("Expected Output/Figures/Mean_Connectivity.pdf")
plot(mySoft$fitIndices$Power, mySoft$fitIndices$mean.k.,
     xlab = "Soft Threshold (Power)", ylab = "Mean Connectivity", 
     main = "Mean Connectivity", type = "b", pch = 19, col = "darkgreen")
dev.off()

# 🧠 8. Adjacency and TOM
myAdjacency <- adjacency(mydata2, power = selected_power)
myTOM <- 1 - TOMsimilarity(myAdjacency)

# 🧱 9. Gene clustering
myclust <- hclust(as.dist(myTOM), method = "average")
myclusters <- cutreeDynamic(myclust, distM = myTOM, minClusterSize = 40)
moduleColors <- labels2colors(myclusters)

pdf("Expected Output/Figures/Cluster_Dendrogram_PreMerge.pdf")
plotDendroAndColors(myclust, moduleColors, 
                    dendroLabels = FALSE, hang = 0.03,
                    addGuide = TRUE, guideHang = 0.05,
                    main = "Dendrogram of Genes (Pre-Merge)")
dev.off()

# 🔁 10. Merge similar modules
mymerge <- mergeCloseModules(mydata2, moduleColors, cutHeight = 0.55)
mergedColors <- mymerge$colors
mergedMEs <- orderMEs(moduleEigengenes(mydata2, mergedColors)$eigengenes)

pdf("Expected Output/Figures/Cluster_Dendrogram_Merged.pdf")
plotDendroAndColors(myclust, cbind(Original = moduleColors, Merged = mergedColors),
                    dendroLabels = FALSE, hang = 0.03,
                    addGuide = TRUE, guideHang = 0.05,
                    main = "Dendrogram of Genes (Merged Modules)")
dev.off()

# 📊 11. Trait correlation
Class$Population <- ifelse(Class$Population == "total_hepatectomy", 1, 0)
Class$Gender <- ifelse(Class$Gender == "M", 1, 0)
traitData <- Class[, c("Population", "Gender", "Age")]

moduleTraitCor <- cor(mergedMEs, traitData, use = "p")
moduleTraitP <- corPvalueStudent(moduleTraitCor, nrow(mydata2))

textMatrix <- paste(signif(moduleTraitCor, 2), "\n(", signif(moduleTraitP, 2), ")", sep = "")
dim(textMatrix) <- dim(moduleTraitCor)

pdf("Expected Output/Figures/Heatmap.pdf")
labeledHeatmap(Matrix = moduleTraitCor,
               xLabels = colnames(traitData),
               yLabels = names(mergedMEs),
               ySymbols = names(mergedMEs),
               colorLabels = FALSE,
               colors = blueWhiteRed(100),
               textMatrix = textMatrix,
               setStdMargins = FALSE,
               cex.text = 0.8,
               zlim = c(-1,1),
               main = "Module-trait relationships")
dev.off()

# 🧬 12. Green module hub gene extraction
targetModule <- "green"
genesInModule <- (mergedColors == targetModule)

MM <- cor(mydata2, mergedMEs[, paste0("ME", targetModule)], use = "p")
GS <- cor(mydata2, traitData$Population, use = "p")

# 📉 13. MM vs GS
r_MM_GS <- cor(MM[genesInModule], GS[genesInModule], use = "complete.obs")
p_MM_GS <- corPvalueStudent(r_MM_GS, sum(genesInModule))

pdf("Expected Output/Figures/MM_vs_GS_GreenModule.pdf")
plot(MM[genesInModule], GS[genesInModule],
     xlab = paste("Module Membership in", targetModule, "module"),
     ylab = "Gene Significance for Population",
     main = paste("MM vs GS\n", targetModule, "module\n",
                  "r =", signif(r_MM_GS, 2), ", p =", signif(p_MM_GS, 2)),
     col = targetModule, pch = 19)
abline(lm(GS[genesInModule] ~ MM[genesInModule]), col = "grey")
dev.off()

# 🧬 14. Export hub genes
hub_criteria <- genesInModule & abs(MM) > 0.8 & abs(GS) > 0.2
hub_gene_ids <- rownames(filteredData)[hub_criteria]

annot <- read.csv("Client Inputs/Human.GRCh38.p13.annot.csv", header = TRUE, stringsAsFactors = FALSE)
annot$GeneID <- as.character(annot$GeneID)
filtered_ids <- rownames(filteredData)
annot_all <- annot[match(filtered_ids, annot$GeneID), c("GeneID", "Symbol")]
filteredData_annotated <- cbind(Symbol = annot_all$Symbol, filteredData)

hub_annot <- annot[match(hub_gene_ids, annot$GeneID), c("GeneID", "Symbol")]
hub_annot$Symbol[is.na(hub_annot$Symbol)] <- hub_annot$GeneID[is.na(hub_annot$Symbol)]

write.csv(filteredData_annotated, "Expected Output/GSE148355_FilteredData_Annotated.csv", row.names = FALSE)
write.csv(hub_annot, "Expected Output/GreenModule_HubGenes_Annotated.csv", row.names = FALSE)
