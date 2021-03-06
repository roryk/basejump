% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/markdownPlotlist.R
\name{markdownPlotlist}
\alias{markdownPlotlist}
\alias{mdPlotlist}
\title{Markdown Plotlist}
\usage{
markdownPlotlist(plotlist, headerLevel = 2L)
}
\arguments{
\item{plotlist}{\code{list} containing \code{ggplot} objects.}

\item{headerLevel}{\code{scalar integer}. Markdown header level (1-7).}
}
\value{
Graphical output of plots, separated by Markdown headers.
}
\description{
Markdown Plotlist
}
\examples{
loadRemoteData("http://basejump.seq.cloud/plotlist.rda")
markdownPlotlist(plotlist)
}
\seealso{
\code{\link[cowplot:plot_grid]{cowplot::plot_grid()}}.

Other R Markdown Functions: \code{\link{kables}},
  \code{\link{markdownHeader}}, \code{\link{markdownLink}},
  \code{\link{markdownList}}
}
\author{
Michael Steinbaugh
}
\concept{R Markdown Functions}
