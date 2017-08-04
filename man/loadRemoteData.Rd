% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllGenerics.R, R/methods-loadRemote.R
\docType{methods}
\name{loadRemoteData}
\alias{loadRemoteData}
\alias{loadRemoteData,character-method}
\title{Load Remote Data}
\usage{
loadRemoteData(object)

\S4method{loadRemoteData}{character}(object)
}
\arguments{
\item{object}{Object.}
}
\value{
No value.
}
\description{
Load a remote R binary file.
}
\examples{
\dontrun{
loadRemoteData("http://example.com/data.rda")
}
}
\seealso{
Other Data Import and Project Utilities: \code{\link{createProjectDirs}},
  \code{\link{loadData}}, \code{\link{packageSE}},
  \code{\link{readDataRaw}},
  \code{\link{readFileByExtension}},
  \code{\link{readYAML}}, \code{\link{transmit}}
}