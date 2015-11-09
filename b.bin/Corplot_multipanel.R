suppressPackageStartupMessages(library(ggplot2, quietly=TRUE))
require("RColorBrewer") ## from CRAN

args <- commandArgs(TRUE)
file <- args[1]
#file <- "/Users/zhoudu/Projects/Feilong/d.analysis/correlation/Amp.readcount.txt"
pngname <- args[2]
slabel <- args[3:]

# Load values
c <- log2(read.table(file, header=T, row.names=1))
c[c < 0] <- NA

png(pngname,units="in",res=150,width=10,height=10)

# panel plot function
panel.plot <- function( x,y, ... )
{
    par(new=TRUE)
    m <- cbind(x,y)
    # define dot color using densCols func
    plot(m,col=densCols(m),pch=20)
    #lines(lowess(m[!is.na(m[,1])&!is.na(m[,2]),]),col="red")
}

panel.cor <- function(x, y, digits=2, prefix="", cex.cor, ...)
{
    usr <- par("usr"); on.exit(par(usr))
    par(usr = c(0, 1, 0, 1))
    r <- cor(x, y, use="complete")
    txt <- format(round(r,2),width=5,nsmall=2)
    #format(c(r, 0.123456789), digits=digits)[1]
    txt <- paste(prefix, txt, sep="")
    if(missing(cex.cor)) cex.cor <- 0.8/strwidth(txt)
    text(0.5, 0.5, txt, cex = cex.cor)
}

pairs(c, lower.panel=panel.plot, upper.panel=panel.cor, labels=slabel)
dev.off()