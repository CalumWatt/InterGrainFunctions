#' A package to convert Agrobase output files into Fieldscorer input files
#'
#' Fieldscorer takes an output file from Agrobase and converts it into a fieldscorer format.
#'
#' @param x A data.frame.
#' @param Experiment A character string indexing column that contains trial names.
#' @param Trialtype A character string to represent trial series. For example "21WS2E".
#' @param plotbarcode A character string indexing column that contains plot barcodes.
#' @param Column A character string indexing the column that contains information pertaining to ranges. Fieldscorer accepts "Column" only.
#' @param Row A character string indexing the column that contains information pertaining to rows.
#' @param Genotype A character string indexing the column that contains genotype names.
#' @param Pedigree  A character string indexing the column that contains pedigree information.
#'
#'
#' @return File format suitable for upload into the Fieldscorer app.
#'
#' @author Calum Watt, \email{cwatt@@intergrain.com}
#' @keywords utilities
#' @examples 
#' data <- read_xls("agrobasepractice.xls")
#' 
#' Fieldscorer(data, 
#'       Experiment = "trial.name",
#'       Trialtype = "21WS2E", 
#'       Barcode = "plot.barcode", 
#'       Column = "pcol", 
#'       Row = "prow",
#'       Genotype = "name",
#'       Pedigree = "pedigree")
#' @export
#' 
Fieldscorer <- function(x, Experiment, Trialtype, Barcode = NULL, Genotype){
  x$Trialtype <- Trialtype
  if(is.null(Barcode))
    x
  else(
    x$PlotBarcode <- x[[Barcode]]
  )
  x$SiteYear <- lubridate::year(now()) #current year
  Sites <- colnames(x[, grep(Experiment, colnames(x), ignore.case = TRUE)])
  x$Experiment <- x[[Sites]]
  Rangecol <- colnames(x[,grep("pcol", colnames(x), ignore.case = TRUE)])
  x$Column <- x[[Rangecol]]
  Rowcol <- colnames(x[,grep("prow", colnames(x), ignore.case = TRUE)])
  x$Row <- x[[Rowcol]]
  x$Genotype <- x[[Genotype]]
  x$Zad <- ""
  
  x <- x[,c("Experiment", "SiteYear", "Trialtype","PlotBarcode", "Column", "Row", "Genotype", "Zad")]
  
  x <- x[!duplicated(x[,c("Experiment", "Column", "Row")]),]
  
  x <- x[order(x$SiteYear, x$Experiment, x$Column, x$Row),]
  trials <- unique(x$Experiment)
  trial_number <- length(trials)
  
  n = 1
  for (i in 1:trial_number) {
    fileName = paste(trials,".csv", sep = "")
    x = subset(x, x$Experiment == trials[i])
    x = x[order(x$Column,x$Row),]
    write.csv(x, fileName, row.names=F, na="",quote=FALSE)
    
  }
}