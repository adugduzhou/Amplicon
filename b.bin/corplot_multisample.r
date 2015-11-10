if (commandArgs()[1] != "RStudio") {
    ARGS <- c(
        "input","character","file path of input file",
        "pngname","character","define name of scatterplot",
        "labellist","character","labels for each sample, seperate by , "
   )
    
    OPTS <- c(
    )
    
    argv <- commandArgs(trailingOnly = FALSE)
    source("/Users/zhoudu/Projects/Feilong/b.bin/Rsub.R")
    parseArgs("Corplot_multipanel.R", ARGS, OPTS)
    samplelabels <- unlist(strsplit(labellist,","))

} else {
    input <- "/Users/zhoudu/Projects/Feilong/d.analysis/correlation/Amp.readcount.txt"
    pngname <- "/Users/zhoudu/Projects/Feilong/d.analysis/correlation"
    source("/Users/zhoudu/Projects/Feilong/pipelines/Rtest/shm_pipeline/R/Rsub.R")
    source("/Users/zhoudu/Projects/Feilong/pipelines/Rtest/shm_pipeline/R/SHMHelper.R")
}

require("RColorBrewer") ## from CRAN

# Load values
c <- log2(read.table(input, header=T, row.names=1))
c[c < 0] <- NA

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

png(pngname,units="in",res=150,width=10,height=10)
pairs(c, lower.panel=panel.plot, upper.panel=panel.cor, labels=samplelabels)
dev.off()
