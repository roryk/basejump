% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/assert.R
\name{assertIsFillScaleContinuousOrNULL}
\alias{assertIsFillScaleContinuousOrNULL}
\title{Assert Is Fill Palette Scale Continuous or NULL}
\usage{
assertIsFillScaleContinuousOrNULL(x,
  severity = getOption("assertive.severity", "stop"))
}
\arguments{
\item{x}{Object.}

\item{severity}{\code{string}. How severe should the consequences of the assertion
be? Either "\code{stop}", "\code{warning}", "\code{message}", or "\code{none}".}
}
\value{
Stop on mismatch.
}
\description{
Assert Is Fill Palette Scale Continuous or NULL
}
\examples{
fill <- ggplot2::scale_fill_gradient(low = "red", high = "blue")
class(fill)
assertIsFillScaleContinuousOrNULL(fill)
assertIsFillScaleContinuousOrNULL(NULL)
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
  \code{\link{assertIsFillScaleDiscreteOrNULL}},
  \code{\link{assertIsGene2symbol}},
  \code{\link{assertIsHexColorFunctionOrNULL}},
  \code{\link{assertIsImplicitInteger}},
  \code{\link{assertIsTx2gene}}, \code{\link{assertIsURL}}
}
\author{
Michael Steinbaugh
}
\concept{Assert Check Functions}
