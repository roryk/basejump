context("R Markdown Functions")

# kables =======================================================================
test_that("kables : list", {
    # Simulate a knit session
    expect_is(
        kables(
            list = list(head(ggplot2::mpg), head(datasets::mtcars)),
            captions = c("mpg", "mtcars"),
            force = TRUE
        ),
        "knit_asis"
    )
    # Check for unmodified return in R session
    expect_is(
        kables(
            list = list(head(ggplot2::mpg), head(datasets::mtcars)),
            captions = c("mpg", "mtcars"),
            force = FALSE
        ),
        "list"
    )
})



# markdownHeader ===============================================================
test_that("markdownHeader", {
    md <- markdownHeader("Header")
    expect_is(md, "knit_asis")
    md <- markdownHeader("Header", level = 4L) %>%
        as.character()
    expect_identical(
        md,
        "#### Header\n"  # nolint
    )
    md <- markdownHeader("Header", tabset = TRUE) %>%
        as.character()
    expect_identical(
         md,
        "## Header {.tabset}\n"  # nolint
    )
    expect_output(
        markdownHeader("Header", asis = TRUE),
        "\\n\\n## Header\\n"  # nolint
    )
    expect_error(
        markdownHeader("Header", level = 8L),
        "is_subset : The element '8'"
    )
})



# markdownLink =================================================================
test_that("markdownLink", {
    expect_identical(
        capture.output(markdownLink(
            text = "R",
            url = "https://www.r-project.org",
            title = "The R Project for Statistical Computing"
        )),
        paste(
            "[R](https://www.r-project.org):",
            "The R Project for Statistical Computing"
        )
    )
})



# markdownList =================================================================
test_that("markdownList", {
    groceries <- c("milk", "eggs")
    md <- markdownList(groceries)
    expect_identical(
        class(md),
        "knit_asis"
    )
    md <- markdownList(groceries) %>%
        as.character()
    expect_identical(
        md,
        c("- milk\n", "- eggs\n")
    )
    md <- markdownList(groceries, ordered = TRUE) %>%
        as.character()
    expect_identical(
        md,
        c("1. milk\n", "2. eggs\n")
    )
    expect_output(
        markdownList(groceries, asis = TRUE),
        "\\n- milk\\n- eggs\\n"
    )
})



# markdownPlotlist =============================================================
test_that("markdownPlotlist", {
    output <- capture.output(
        markdownPlotlist(plotlist)
    )
    expect_identical(
        output,
        c(
            "",
            "",
            "## continuous",
            "",
            "",
            "",
            "## discrete",
            ""
        )
    )
})
