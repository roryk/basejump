% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllGenerics.R, R/geometricMean-methods.R
\docType{methods}
\name{geometricMean}
\alias{geometricMean}
\alias{geometricMean,numeric-method}
\alias{geometricMean,matrix-method}
\alias{geometricMean,data.frame-method}
\title{Geometric Mean}
\usage{
geometricMean(object, ...)

\S4method{geometricMean}{numeric}(object, removeNA = TRUE,
  zeroPropagate = FALSE)

\S4method{geometricMean}{matrix}(object)

\S4method{geometricMean}{data.frame}(object)
}
\arguments{
\item{object}{Object.}

\item{...}{Additional arguments.}

\item{removeNA}{\code{boolean}. Remove \code{NA} values from calculations.}

\item{zeroPropagate}{\code{boolean}. Allow propagation of zeroes.}
}
\value{
\code{numeric} containing geometric means.
}
\description{
The geometric mean is the nth root of n products or e to the mean log of \code{x}.
Useful for describing non-normal (i.e. geometric) distributions.
}
\details{
This function should be fully zero- and \code{NA}-tolerant. This calculation is
not particularly useful if there are elements that are <= 0 and will return
\code{NaN}.
}
\examples{
# numeric ====
vec <- seq(1L, 5L, 1L)
geometricMean(vec)
vec2 <- vec ^ 2L
geometricMean(vec2)

# data.frame ====
df <- data.frame(vec, vec2)
geometricMean(df)

# matrix ====
mat <- as.matrix(df)
geometricMean(mat)
}
\seealso{
Modified version of \code{psych::geometric.mean()} and Paul McMurdie's
\href{https://stackoverflow.com/a/25555105}{code}.

Other Math and Science Functions: \code{\link{foldChangeToLogRatio}},
  \code{\link{microplate}}
}
\author{
Michael Steinbaugh
}
\concept{Math and Science Functions}
