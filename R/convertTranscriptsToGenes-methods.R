#' Convert Ensembl Transcripts to Genes
#'
#' @name convertTranscriptsToGenes
#' @family Annotation Functions
#' @author Michael Steinbaugh
#'
#' @inherit convertGenesToSymbols
#'
#' @param tx2gene `data.frame` or `NULL`. Transcript-to-gene mappings. If set
#'   `NULL`, the function will attempt to download the mappings from Ensembl
#'   automatically.
#' @param ... Passthrough to [makeTx2geneFromEnsembl()].
#'
#' @examples
#' # character ====
#' x <- c("ENSMUST00000000001", "ENSMUST00000000003", "ENSMUST00000114041")
#' convertTranscriptsToGenes(x)
#'
#' # matrix ====
#' mat <- matrix(
#'     data = seq(1L:6L),
#'     byrow = TRUE,
#'     nrow = 3L,
#'     ncol = 2L,
#'     dimnames = list(
#'         c("ENSMUST00000000001", "ENSMUST00000000003", "ENSMUST00000114041"),
#'         c("sample_1", "sample_2")
#'     )
#' )
#' print(mat)
#' mat <- convertTranscriptsToGenes(mat)
#' print(mat)
#' rownames(mat)
NULL



#' @rdname convertTranscriptsToGenes
setMethod(
    "convertTranscriptsToGenes",
    signature("character"),
    function(
        object,
        tx2gene = NULL,
        ...
    ) {
        assert_all_are_non_missing_nor_empty_character(object)
        assert_has_no_duplicates(object)
        assert_is_any_of(tx2gene, c("data.frame", "NULL"))
        args <- list(...)
        organism <- args[["organism"]]

        # If no tx2gene is provided, fall back to using Ensembl annotations
        if (is.null(tx2gene)) {
            message("Obtaining transcript-to-gene mappings from Ensembl")
            if (is.null(organism)) {
                organism <- detectOrganism(object, unique = TRUE)
            }
            assert_is_a_string(organism)
            message(paste(organism, "genes detected"))
            args[["organism"]] <- organism
            tx2gene <- do.call(
                what = makeTx2geneFromEnsembl,
                args = args
            )
        }
        assertIsTx2gene(tx2gene)

        missing <- setdiff(object, tx2gene[["transcriptID"]])
        if (length(missing)) {
            stop(paste("Failed to match transcripts:", toString(missing)))
        }

        tx2gene <- tx2gene[
            match(x = object, table = tx2gene[["transcriptID"]]),
            ,
            drop = FALSE
        ]

        return <- tx2gene[["geneID"]]
        names(return) <- tx2gene[["transcriptID"]]
        return
    }
)



#' @rdname convertTranscriptsToGenes
#' @export
setMethod(
    "convertTranscriptsToGenes",
    signature("matrix"),
    function(object, ...) {
        rownames <- convertTranscriptsToGenes(rownames(object), ...)
        rownames(object) <- rownames
        object
    }
)



#' @rdname convertTranscriptsToGenes
#' @export
setMethod(
    "convertTranscriptsToGenes",
    signature("data.frame"),
    getMethod("convertTranscriptsToGenes", "matrix")
)



#' @rdname convertTranscriptsToGenes
#' @export
setMethod(
    "convertTranscriptsToGenes",
    signature("DataFrame"),
    getMethod("convertTranscriptsToGenes", "data.frame")
)



#' @rdname convertTranscriptsToGenes
#' @export
setMethod(
    "convertTranscriptsToGenes",
    signature("dgCMatrix"),
    getMethod("convertTranscriptsToGenes", "matrix")
)



#' @rdname convertTranscriptsToGenes
#' @export
setMethod(
    "convertTranscriptsToGenes",
    signature("dgTMatrix"),
    getMethod("convertTranscriptsToGenes", "matrix")
)
