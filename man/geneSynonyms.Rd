% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/geneSynonyms.R
\name{geneSynonyms}
\alias{geneSynonyms}
\title{Gene Synonyms}
\usage{
geneSynonyms(organism = c("Homo sapiens", "Mus musculus",
  "Drosophila melanogaster"))
}
\arguments{
\item{organism}{\code{string}. Spported organisms: \emph{Homo sapiens}, \emph{Mus musculus},
\emph{Drosophila melanogaster}.}
}
\value{
\code{grouped_df}, grouped by \code{geneID} column.
}
\description{
Look up gene synonyms from NCBI.
}
\note{
Synonym support for \emph{Caenorhabditis elegans} is poor on NCBI.
Use the wormbase package instead.
}
\examples{
x <- geneSynonyms(organism = "Homo sapiens")
glimpse(x)
}
\seealso{
Other Annotation Functions: \code{\link{annotable}},
  \code{\link{broadClass}},
  \code{\link{convertGenesToSymbols}},
  \code{\link{convertTranscriptsToGenes}},
  \code{\link{convertUCSCBuildToEnsembl}},
  \code{\link{detectOrganism}}, \code{\link{eggnog}},
  \code{\link{emptyRanges}}, \code{\link{hgnc2gene}},
  \code{\link{makeGRangesFromEnsembl}},
  \code{\link{makeGRangesFromGFF}},
  \code{\link{makeGene2symbolFromEnsembl}},
  \code{\link{makeGene2symbolFromGFF}},
  \code{\link{makeTx2geneFromEnsembl}},
  \code{\link{makeTx2geneFromGFF}}, \code{\link{mgi2gene}},
  \code{\link{panther}},
  \code{\link{stripTranscriptVersions}}
}
\author{
Michael Steinbaugh
}
\concept{Annotation Functions}
