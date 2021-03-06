# nolint start
# snake_case, following ggplot2 conventions



#' Complete Themes
#'
#' [ggplot2](http://ggplot2.tidyverse.org) themes.
#'
#' @name themes
#' @family Plot Functions
#' @author Michael Steinbaugh
#'
#' @param base_size `scalar numeric`. Base font size.
#' @param base_family `string`. Base font family.
#' @param face `string`. Font face ("`bold`", "`plain`").
#' @param aspect_ratio `scalar numeric`. Aspect ratio, specifying the plot
#'   proportions. Use `1` for a perfectly square plot (including the axis
#'   labels).
#' @param legend_position `string`. Legend key position. We're being a little
#'   more restrictive here, only allowing "`bottom`", "`right`", or "`none`".
#'   Including the legend at the top or the left side of the plot rarely makes
#'   sense and is discouraged.
#' @param grid `boolean`. Label the major panel grids. If `TRUE`, the axis lines
#'   will also be removed.
#'
#' @return `theme`.
#'
#' @seealso [ggplot2::theme()].
#'
#' @examples
#' library(ggplot2)
#'
#' # Example ggplot object
#' p <- ggplot(
#'     data = mpg,
#'     mapping = aes(
#'         x = manufacturer,
#'         y = displ,
#'         colour = manufacturer
#'     )
#' ) +
#'     geom_point()
NULL



#' @rdname themes
#' @export
#'
#' @section Midnight Theme:
#' Blackout theme that sets the plot background as black, with white text.
#' Inspired by `Seurat::DarkTheme()`, with some color modifications. Useful
#' for visualizing many points with a high dynamic color range, such as t-SNE
#' expression plots.
#'
#' @examples
#' # Midnight Theme
#' p + theme_midnight(aspect_ratio = 1L, legend_position = "none")
theme_midnight <- function(
    base_size = 14L,
    base_family = "",
    face = c("bold", "plain"),
    aspect_ratio = NULL,
    legend_position = c("right", "bottom", "none"),
    grid = FALSE
) {
    assert_is_a_number(base_size)
    assert_is_a_string(base_family)
    face <- match.arg(face)
    assertIsANumberOrNULL(aspect_ratio)
    legend_position <- match.arg(legend_position)
    assert_is_a_bool(grid)

    gray <- "gray10"

    text <- element_text(
        family = base_family,
        face = face,
        colour = "white"
    )

    if (isTRUE(grid)) {
        axis_ticks <- element_blank()
        panel_grid_major <- element_line(colour = gray, size = 0.5)
        panel_border <- element_blank()
    } else {
        axis_ticks <- element_line(colour = "white")
        panel_grid_major <- element_blank()
        panel_border <- element_rect(colour = "white", fill = NA)
    }

    theme_linedraw(
        base_size = base_size,
        base_family = base_family
    ) +
        theme(
            text = text,
            aspect.ratio = aspect_ratio,
            axis.line = element_blank(),
            axis.text = text,
            axis.text.x = element_text(angle = 90L, hjust = 1L, vjust = 0.5),
            axis.ticks = axis_ticks,
            legend.key = element_rect(colour = NA, fill = gray),
            legend.background = element_blank(),
            legend.position = legend_position,
            panel.background = element_blank(),
            panel.border = panel_border,
            panel.grid.major = panel_grid_major,
            panel.grid.minor = element_blank(),
            plot.background = element_rect(colour = NA, fill = "black"),
            strip.text = text,
            complete = TRUE,
            validate = TRUE
        )
}



#' @rdname themes
#' @export
#'
#' @section Paperwhite Theme:
#' High contrast black and white theme optimized for print. Recommended for
#' scientific manuscripts and website tutorials.
#'
#' @examples
#' p + theme_paperwhite(aspect_ratio = 1L, legend_position = "none")
theme_paperwhite <- function(
    base_size = 14L,
    base_family = "",
    face = c("bold", "plain"),
    aspect_ratio = NULL,
    legend_position = c("right", "bottom", "none"),
    grid = FALSE
) {
    assert_is_a_number(base_size)
    assert_is_a_string(base_family)
    face <- match.arg(face)
    assertIsANumberOrNULL(aspect_ratio)
    legend_position <- match.arg(legend_position)
    assert_is_a_bool(grid)

    gray <- "gray95"

    text <- element_text(
        family = base_family,
        face = face,
        colour = "black"
    )

    if (isTRUE(grid)) {
        axis_ticks <- element_blank()
        panel_grid_major <- element_line(colour = gray, size = 0.5)
        panel_border <- element_blank()
    } else {
        axis_ticks <- element_line(colour = "black")
        panel_grid_major <- element_blank()
        panel_border <- element_rect(colour = "black", fill = NA)
    }

    theme_linedraw(
        base_size = base_size,
        base_family = base_family
    ) +
        theme(
            text = text,
            aspect.ratio = aspect_ratio,
            axis.line = element_blank(),
            axis.text = text,
            axis.text.x = element_text(angle = 90L, hjust = 1L, vjust = 0.5),
            axis.ticks = axis_ticks,
            panel.background = element_blank(),
            panel.border = panel_border,
            panel.grid.major = panel_grid_major,
            panel.grid.minor = element_blank(),
            legend.background = element_blank(),
            legend.position = legend_position,
            strip.background = element_rect(colour = NA, fill = "white"),
            strip.text = text,
            complete = TRUE,
            validate = TRUE
        )
}



# nolint end
