#' Coerce to `tibble` Class Object
#'
#' Coerce an object to a `tibble` (`tbl_df`). Tibbles don't support rowname
#' assignemnt, so here we are ensuring they are kept by moving them to a column
#' named `rowname` upon coercion. This helps avoid downstream unexpected data
#' loss when using the dplyr chain of single table verbs, such as
#' [dplyr::arrange()], [dplyr::filter()], or [dplyr::mutate()].
#'
#' @name coerce-tibble
#' @author Michael Steinbaugh
#'
#' @seealso
#' - `help(topic = "tibble", package = "tibble")`
#' - `help(topic = "coerce", package = "methods")`.
#'
#' @examples
#' # data.frame ====
#' # Automatically move rownames to `rowname` column
#' as(datasets::mtcars, "tibble") %>% glimpse()
#'
#' # tibble ====
#' # Return unmodified
#' as(ggplot2::mpg, "tibble") %>% glimpse()
NULL



# Constructors =================================================================
.tibble <- function(from) {
    if (is_tibble(from)) {
        return(from)  # nocov
    }
    from <- as.data.frame(from)
    assert_has_colnames(from)
    if (has_rownames(from)) {
        from <- rownames_to_column(from)
    }
    as_tibble(from)
}



# Methods ======================================================================
setAs(from = "matrix", to = "tbl_df", def = .tibble)
setAs(from = "data.frame", to = "tbl_df", def = .tibble)
setAs(from = "DataFrame", to = "tbl_df", def = .tibble)
setAs(from = "GRanges", to = "tbl_df", def = .tibble)

setAs(from = "matrix", to = "tibble", def = .tibble)
setAs(from = "data.frame", to = "tibble", def = .tibble)
setAs(from = "DataFrame", to = "tibble", def = .tibble)
setAs(from = "GRanges", to = "tibble", def = .tibble)