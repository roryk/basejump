% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/assert.R
\name{assertIsGene2symbol}
\alias{assertIsGene2symbol}
\title{Assert Is Gene to Symbol Mapping Data Frame}
\usage{
assertIsGene2symbol(x, severity = getOption("assertive.severity",
  "stop"))
}
\arguments{
\item{x}{\code{data.frame} containing Ensembl gene-to-symbol mappings. Must be
structured as a two column \code{data.frame} with "\code{geneID}" and "\code{geneName}"
columns.}

\item{severity}{\code{string}. How severe should the consequences of the assertion
be? Either "\code{stop}", "\code{warning}", "\code{message}", or "\code{none}".}
}
\value{
Stop on mismatch.
}
\description{
Assert Is Gene to Symbol Mapping Data Frame
}
\examples{
x <- tibble(
    geneID = "ENSG00000000003",
    geneName = "TSPAN6"
)
assertIsGene2symbol(x)
}
\seealso{
Other Assert Check Functions: \code{\link{assertAllAreNonExisting}},
  \code{\link{assertAreGeneAnnotations}},
  \code{\link{assertAreTranscriptAnnotations}},
  \code{\link{assertFormalCompress}},
  \code{\link{assertFormalGene2symbol}},
  \code{\link{assertFormalInterestingGroups}},
  \code{\link{assertHasRownames}},
  \code{\link{assertIsAHeaderLevel}},
  \code{\link{assertIsANumberOrNULL}},
  \code{\link{assertIsAStringOrNULL}},
  \code{\link{assertIsAnIntegerOrNULL}},
  \code{\link{assertIsCharacterOrNULL}},
  \code{\link{assertIsColorScaleContinuousOrNULL}},
  \code{\link{assertIsColorScaleDiscreteOrNULL}},
  \code{\link{assertIsDataFrameOrNULL}},
  \code{\link{assertIsFillScaleContinuousOrNULL}},
  \code{\link{assertIsFillScaleDiscreteOrNULL}},
  \code{\link{assertIsHexColorFunctionOrNULL}},
  \code{\link{assertIsImplicitInteger}},
  \code{\link{assertIsTx2gene}}, \code{\link{assertIsURL}}
}
\author{
Michael Steinbaugh
}
\concept{Assert Check Functions}
