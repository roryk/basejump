% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllGenerics.R, R/plotHeatmap-methods.R
\docType{methods}
\name{plotHeatmap}
\alias{plotHeatmap}
\alias{plotHeatmap,SummarizedExperiment-method}
\title{Plot Heatmap}
\usage{
plotHeatmap(object, ...)

\S4method{plotHeatmap}{SummarizedExperiment}(object, interestingGroups,
  scale = c("row", "column", "none"), clusterRows = TRUE,
  clusterCols = TRUE, showRownames = FALSE, showColnames = TRUE,
  treeheightRow = 0L, treeheightCol = 50L, color = viridis::viridis,
  legendColor = NULL, borderColor = NULL, title = NULL, ...)
}
\arguments{
\item{object}{Object.}

\item{...}{Passthrough arguments to \code{\link[pheatmap:pheatmap]{pheatmap::pheatmap()}}. The names of the
arguments should be formatted in camel case, not snake case.}

\item{interestingGroups}{\code{character}. Groups of interest.}

\item{scale}{\code{string}. Whether the values should be centered and scaled in
either the row or column direction ("\code{row}", "\code{column}"), or remain
unscaled ("\code{none}").}

\item{clusterRows, clusterCols}{\code{boolean}. Arrange with hierarchical
clustering.}

\item{showRownames, showColnames}{\code{boolean}. Show row or column names.}

\item{treeheightRow, treeheightCol}{\code{scalar integer}. Size of the row and
column dendrograms. Use \code{0} to disable.}

\item{color}{\code{function}, \code{character}, or \code{NULL}. Hexadecimal color function
or values to use for plot. We generally recommend these hexadecimal
functions from the viridis package:
\itemize{
\item \code{\link[viridis:viridis]{viridis::viridis()}} (\emph{default}).
\item \code{\link[viridis:inferno]{viridis::inferno()}}.
\item \code{\link[viridis:magma]{viridis::magma()}}.
\item \code{\link[viridis:plasma]{viridis::plasma()}}.
Alternatively, colors can be defined manually using hexadecimal values
(e.g. \code{c("#FF0000", "#0000FF")}), but this is not generally recommended.
Refer to the RColorBrewer package for hexadecimal color palettes that may
be suitable. If set \code{NULL}, will use the default pheatmap colors.
}}

\item{legendColor}{\code{function} or \code{NULL}. Hexadecimal color function to use
for legend labels. Note that hexadecimal values are not supported. If set
\code{NULL}, will use the default pheatmap colors.}

\item{borderColor}{\code{string} or \code{NULL}. Border color. Disabled by default for
improved aesthetics.}

\item{title}{\code{string} or \code{NULL}. Plot title.}
}
\value{
Show heatmap and invisibly return a \code{list} of the components.
}
\description{
Construct a simple heatmap. By default, row- and column-wise hierarchical
clustering is performed using the Ward method, but this behavior can be
overrided by setting \code{clusterRows} or \code{clusterCols} to \code{FALSE}.
}
\examples{
# SummarizedExperiment ====
plotHeatmap(rse_dds)

# Set legend using interesting groups, and customize colors
plotHeatmap(
    object = rse_dds,
    interestingGroups = "condition",
    color = viridis::plasma,
    legendColor = viridis::viridis
)

# Hexadecimal color input
library("RColorBrewer")
purple_orange <- colorRampPalette(brewer.pal(n = 11L, name = "PuOr"))(256L)
plotHeatmap(rse_dds, color = purple_orange)

# Default pheatmap colors
plotHeatmap(rse_dds, color = NULL)

# Disable column clustering
plotHeatmap(rse_dds, clusterCols = FALSE)
}
\seealso{
\itemize{
\item \code{\link[pheatmap:pheatmap]{pheatmap::pheatmap()}}.
\item \code{\link[RColorBrewer:brewer.pal]{RColorBrewer::brewer.pal()}}.
}

Other Plot Functions: \code{\link{plotCorrelationHeatmap}},
  \code{\link{plotQuantileHeatmap}}, \code{\link{themes}}
}
\concept{Plot Functions}
