
#' A package to output NVT trial designs
#'
#' NVTconvert takes an NVT provided wide format trial designs and outputs each individual trial as a figure for a user define crop species.
#'
#' @param x A data.frame
#' @param Crop.Species User define crop species i.e. Wheat. Needs to be character input...."Wheat"
#' @param Sub.Series User defined crop sub-series. In wheat there are Durum, Early Season sub-series. Default is NULL.
#' @param Location A character stipulating the name of the column containing the location data...."Site.Location"
#' @param State A character stipulating the name of the column containing the state data...."State"
#' @param Code A character stipulating the name of the colunn containing the trialname data...."Trial.Name"
#'
#' @return Long format data frame and .jpeg trial design figures.
#'
#' @author Calum Watt, \email{cwatt@@intergrain.com}
#' @keywords utilities
#' @export
#' @examples 
#' NVTconvert(data, 
#'          Crop.Species = "Wheat",
#'           Sub.Series = "Main Season", 
#'           Location = "SiteDescription", 
#'           State = "State", Code = "TrialCode")
NVTconvert <- function(x, Crop.Species, Sub.Series = NULL, Location, State, Code){

  cropcol <- colnames(x[,grep("Crop",colnames(x))])
  seriescol <- colnames(x[, grep("series", colnames(x), ignore.case = TRUE)])
  x1 <- x[x[[cropcol]] == as.character(Crop.Species),]
  if(is.null(Sub.Series))
    x1
  else(
    x1 <- x1[x1[[seriescol]] == as.character(Sub.Series),])
  x1$Trialname <- paste(x1[[Location]], "-", x1[["State"]],"-", x1[[Code]], "-", x1[[seriescol]])
  rangeList <- names(x1[grep(c("^1|^2|^3|^4|^5|^6|^7|^8|^9|^10|^11|^12|^13|^14|^15|^16"), names(x1))]) 
  x1 <- pivot_longer(x1, rangeList, names_to = "Range", values_to = "Genotype")
  x1 <- x1[!is.na(x1$Genotype),]
  x1$Trialname <- as.factor(x1$Trialname)
  row <- colnames(x1[,grep("row", colnames(x1), ignore.case = TRUE)])
  x1$Range <- as.factor(x1$Range)
  x1[[row]] <- as.factor(x1[[row]])
  plotlist <- list()
  for (i in 1:length(levels((x1$Trialname)))) {
    temp <- subset(x1, Trialname == levels(Trialname)[i])
    plot <- ggplot(temp, aes(Range, Row, fill = Genotype)) +
      geom_tile() + geom_text(aes(label = Genotype), size  = 3) +
      theme(legend.position = "none") +
      ggtitle(unique(x1$Trialname))
    plotlist[[i]] <- plot
    ggsave(plotlist[[i]], filename = paste(levels(x1$Trialname)[i], ".jpeg"), path = paste(unique(x1$Year),"NVT Trial designs", "-" ,Crop.Species)) # make a new directory for the new figures
  }
}

