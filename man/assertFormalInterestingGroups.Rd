% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/assert.R
\name{assertFormalInterestingGroups}
\alias{assertFormalInterestingGroups}
\title{Interesting Groups Formal Assert Check}
\usage{
assertFormalInterestingGroups(x, interestingGroups,
  severity = getOption("assertive.severity", "stop"))
}
\arguments{
\item{x}{Object.}

\item{interestingGroups}{\code{character}. Groups of interest.}

\item{severity}{\code{string}. How severe should the consequences of the assertion
be? Either "\code{stop}", "\code{warning}", "\code{message}", or "\code{none}".}
}
\value{
Silent, stop on error.
}
\description{
Prevent unwanted downstream behavior when a missing interesting group
is requested by the user.
}
\examples{
assertFormalInterestingGroups(rse_bcb, "treatment")
assertFormalInterestingGroups(rse_dds, "condition")
}
\seealso{
Other Assert Check Functions: \code{\link{assertAllAreNonExisting}},
  \code{\link{assertAreGeneAnnotations}},
  \code{\link{assertAreTranscriptAnnotations}},
  \code{\link{assertFormalCompress}},
  \code{\link{assertFormalGene2symbol}},
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
  \code{\link{assertIsGene2symbol}},
  \code{\link{assertIsHexColorFunctionOrNULL}},
  \code{\link{assertIsImplicitInteger}},
  \code{\link{assertIsTx2gene}}, \code{\link{assertIsURL}}
}
\author{
Michael Steinbaugh
}
\concept{Assert Check Functions}
