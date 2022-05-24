ggplot(data=rnaseq, aes(x = log2FC, y = padj)) + geom_point()
p <- ggplot(data=rnaseq, aes(x=log2FC, y=-log10(padj))) + geom_point() + theme_minimal()
p2 <- p + geom_vline(xintercept = c(-1, 1), col= "red") +
  geom_hline(yintercept = -log10(0.05), col= "red")

ggplot(data=rnaseq, aes(x = log2FC, y = padj)) + geom_point() + theme_minimal()
rnaseq$diffexpressed <- "NO"
rnaseq$diffexpressed[rnaseq$log2FC > 1 & rnaseq$padj < 0.05] <- "UP"
rnaseq$diffexpressed[rnaseq$log2FC < -1 & rnaseq$padj < 0.05] <- "DOWN"

Combo_truncated_DEseq2_Output$diffexpressed[Combo_truncated_DEseq2_Output$log2FC > 1 & Combo_truncated_DEseq2_Output$padj < 0.05] <- "UP"
Combo_truncated_DEseq2_Output$diffexpressed[Combo_truncated_DEseq2_Output$log2FC < -1 & Combo_truncated_DEseq2_Output$padj < 0.05] <- "DOWN"



p <- ggplot(data=rnaseq, aes(x=log2FC, y=-log10(padj), col=diffexpressed)) + geom_point() + theme_minimal()
p2 <- p + geom_vline(xintercept=c(-1, 1), col="red") +
  geom_hline(yintercept=-log10(0.05), col="red")

p3 <- p2 + scale_color_manual(values=c("blue", "black", "red"))

mycolors <- c("blue", "red", "black")
names(mycolors) <- c("DOWN", "UP", "NO")
p3 <- p2 + scale_colour_manual(values = mycolors)

rnaseq$delabel <- NA
rnaseq$delabel[rnaseq$diffexpressed != "NO"] <- rnaseq$SYMBOL[rnaseq$diffexpressed != "NO"]

ggplot(data=rnaseq, aes(x=log2FC, y=-log10(padj), col=diffexpressed, label= delabel)) + 
  geom_point() + 
  theme_minimal() +
  geom_label()

install.packages("ggrepel")
library(ggrepel)
# plot adding up all layers we have seen so far
ggplot(data=rnaseq, aes(x=log2FC, y=-log10(padj), col=diffexpressed, label=delabel)) +
  geom_point() + 
  theme_minimal() +
  geom_text_repel() +
  scale_color_manual(values=c("blue", "red", "black")) +
  geom_vline(xintercept=c(-2, 2), col="purple") +
  geom_hline(yintercept=-log10(0.05), col="purple")






