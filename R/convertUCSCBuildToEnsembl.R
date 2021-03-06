#' Convert UCSC Build to Ensembl
#'
#' @family Annotation Functions
#' @author Michael Steinbaugh
#'
#' @inheritParams general
#'
#' @return `character` containing Ensembl genome build as the value, UCSC build
#'   as the name. Returns `NULL` on match failure.
#' @export
#'
#' @examples
#' convertUCSCBuildToEnsembl(c("hg19", "hg38"))
convertUCSCBuildToEnsembl <- function(object) {
    assert_is_character(object)
    keys <- c(
        # Homo sapiens (Human)
        "GRCh37" = "hg19",
        "GRCh38" = "hg38",
        # Mus musculus (Mouse)
        "GRCm38" = "mm10",
        # Rattus norvegicus (Rat)
        "Rnor_6.0" = "rn6",
        # Drosophila melanogaster (Fruitfly)
        "BDGP6" = "dm6",
        # Caenorhabditis elegans (Worm)
        "WBcel235" = "ce11",
        # Saccharomyces cerevisiae (Yeast)
        "R64-1-1" = "sacCer3"
    )
    match <- match(object, keys)
    if (any(is.na(match))) {
        return(NULL)
    }
    return <- names(keys)[match]
    names(return) <- keys[match]
    return
}
