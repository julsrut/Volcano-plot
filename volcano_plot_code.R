download.file("https://raw.githubusercontent.com/biocorecrg/CRG_RIntroduction/master/de_df_for_volcano.rds", "de_df_for_volcano.rds", method="curl")
tmp <- readRDS("de_df_for_volcano.rds")
View(tmp)

de <- tmp[complete.cases(tmp), ]
View((tmp))
ggplot(data = tmp, aes(x = log2FoldChange, y = pvalue)) + geom_point()

ggplot(data = Combo_truncated_DEseq2_Output, aes(x = log2(FC)_Combo, y = P-adj_Comb)), geom_point()
names(rnaseq)

colnames(Combo_truncated_DEseq2_Output) <- c('geneID', 'basemean', 'log2FC', 'padj')
ggplot(data=Combo_truncated_DEseq2_Output, aes(x = log2FC, y = padj)) + geom_point()
p <- ggplot(data=Combo_truncated_DEseq2_Output, aes(x=log2FC, y=-log10(padj))) + geom_point() + theme_minimal()
p2 <- p + geom_vline(xintercept = c(-1, 1), col= "red") +
  geom_hline(yintercept = -log10(0.05), col= "red")

ggplot(data=Combo_truncated_DEseq2_Output, aes(x = log2FC, y = padj)) + geom_point() + theme_minimal()
Combo_truncated_DEseq2_Output$diffexpressed <- "NO"
Combo_truncated_DEseq2_Output$diffexpressed[Combo_truncated_DEseq2_Output$log2FC > 1 & Combo_truncated_DEseq2_Output$padj < 0.05] <- "UP"
Combo_truncated_DEseq2_Output$diffexpressed[Combo_truncated_DEseq2_Output$log2FC < -1 & Combo_truncated_DEseq2_Output$padj < 0.05] <- "DOWN"


p <- ggplot(data=Combo_truncated_DEseq2_Output, aes(x=log2FC, y=-log10(padj), col=diffexpressed)) + geom_point() + theme_minimal()
p2 <- p + geom_vline(xintercept=c(-1, 1), col="red") +
  geom_hline(yintercept=-log10(0.05), col="red")

p3 <- p2 + scale_color_manual(values=c("blue", "black", "red"))

mycolors <- c("blue", "red", "black")
names(mycolors) <- c("DOWN", "UP", "NO")
p3 <- p2 + scale_colour_manual(values = mycolors)

Combo_truncated_DEseq2_Output$delabel <- NA
Combo_truncated_DEseq2_Output$delabel[Combo_truncated_DEseq2_Output$diffexpressed != "NO"] <- Combo_truncated_DEseq2_Output$geneID[Combo_truncated_DEseq2_Output$diffexpressed != "NO"]

ggplot(data=Combo_truncated_DEseq2_Output, aes(x=log2FC, y=-log10(padj), col=diffexpressed, label= delabel)) + 
  geom_point() + 
  theme_minimal() +
  geom_label()






