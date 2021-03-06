% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sanitizeRowData.R
\name{sanitizeRowData}
\alias{sanitizeRowData}
\title{Sanitize Row Data}
\usage{
sanitizeRowData(object)
}
\arguments{
\item{object}{Object.}
}
\value{
\code{data.frame}, without any nested \code{list} columns.
}
\description{
Coerce Ensembl \code{rowData} to a \code{data.frame}, and drop any nested list columns
(e.g. \code{entrezID}). Nested columns will fail to write to disk as CSVs.
}
\details{
Supports \code{GRanges}, \code{DataFrame}, and \code{data.frame} class objects.
}
\examples{
# Genes ====
x <- makeGRangesFromEnsembl("Homo sapiens", format = "genes")
sanitizeRowData(x) \%>\% glimpse()

# Transcripts ====
x <- makeGRangesFromEnsembl("Homo sapiens", format = "transcripts")
sanitizeRowData(x) \%>\% glimpse()
}
\seealso{
Other Sanitization Functions: \code{\link{camel}},
  \code{\link{collapseToString}}, \code{\link{fixNA}},
  \code{\link{removeNA}}, \code{\link{sanitizeSampleData}}
}
\author{
Michael Steinbaugh
}
\concept{Sanitization Functions}
