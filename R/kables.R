#' Create Multiple Tables in LaTeX, HTML, Markdown and reStructuredText
#'
#' Knit multiple tables in a single R Markdown chunk.
#'
#' @family R Markdown Functions
#' @author Michael Steinbaugh
#'
#' @param list `list` containing column data (e.g. `data.frame`, `matrix`).
#' @param captions `character`. Table captions.
#' @param force `boolean`. Force knit output. Recommended for development and
#'   unit testing only.
#'
#' @return Knit tables.
#' @export
#'
#' @seealso
#' - [knitr::kable()].
#' - [Stack Overflow post](https://stackoverflow.com/a/35149103/3911732).
#'
#' @examples
#' kables(
#'     list = list(head(ggplot2::mpg), head(datasets::mtcars)),
#'     captions = c("mpg", "mtcars")
#' )
kables <- function(
    list,
    captions,
    force = FALSE
) {
    assert_is_list(list)
    assert_is_character(captions)
    assert_are_same_length(list, captions)
    assert_is_a_bool(force)
    output <- opts_knit[["get"]]("rmarkdown.pandoc.to")
    if (!is.null(output) || isTRUE(force)) {
        tables <- mapply(
            x = list,
            caption = captions,
            FUN = function(x, caption) {
                kable(x, caption = caption)
            },
            SIMPLIFY = FALSE,
            USE.NAMES = TRUE
        )
        asis_output(tables)
    } else {
        # Return the unmodified list if not in a knit call
        list
    }
}
