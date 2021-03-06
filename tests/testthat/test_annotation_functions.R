context("Annotation Functions")



# annotable ====================================================================
test_that("annotable", {
    x <- annotable("Homo sapiens", release = ensemblRelease)
    expect_is(x, "data.frame")
    expect_identical(dim(x), c(63970L, 12L))
    expect_identical(rownames(x)[[1L]], "ENSG00000000003")
})



# broadClass ===================================================================
test_that("broadClass", {
    # GRanges
    expect_is(
        broadClass(makeGRangesFromEnsembl("Homo sapiens")),
        "factor"
    )

    # SummarizedExperiment
    expect_is(
        broadClass(rse_bcb),
        "factor"
    )
})



# convertGenesToSymbols ========================================================
test_that("convertGenesToSymbols : character", {
    x <- c("ENSMUSG00000000001", "ENSMUSG00000000003")
    y <- c(
        "ENSMUSG00000000001" = "Gnai3",
        "ENSMUSG00000000003" = "Pbsn"
    )

    # gene2symbol (recommended)
    gene2symbol <- makeGene2symbolFromEnsembl(
        organism = "Mus musculus",
        release = ensemblRelease
    )
    expect_identical(
        convertGenesToSymbols(x, gene2symbol = gene2symbol),
        y
    )

    # organism
    expect_identical(
        convertGenesToSymbols(
            x,
            organism = "Mus musculus",
            release = ensemblRelease
        ),
        y
    )

    # No tx2gene or organism
    expect_identical(
        convertGenesToSymbols(x, release = ensemblRelease),
        y
    )
})

test_that("convertGenesToSymbols : matrix", {
    x <- matrix(
        data = seq(1L:4L),
        byrow = TRUE,
        nrow = 2L,
        ncol = 2L,
        dimnames = list(
            c("ENSMUSG00000000001", "ENSMUSG00000000003"),
            c("sample_1", "sample_2")
        )
    )
    expect_identical(
        convertGenesToSymbols(x, release = ensemblRelease) %>%
            rownames(),
        c(
            "ENSMUSG00000000001" = "Gnai3",
            "ENSMUSG00000000003" = "Pbsn"
        )
    )
})

test_that("convertGenesToSymbols : FASTA spike-in support", {
    # Specify organism (to handle FASTA spike-ins (e.g. EGFP)
    x <- c("EGFP", "ENSMUSG00000000001")
    expect_identical(
        suppressWarnings(
            convertGenesToSymbols(
                object = x,
                organism = "Mus musculus",
                release = ensemblRelease
            )
        ),
        c(EGFP = "EGFP", "ENSMUSG00000000001" = "Gnai3")
    )
})

test_that("convertGenesToSymbols : Invalid identifiers", {
    expect_warning(
        convertGenesToSymbols("ENSMUSG00000000000", release = ensemblRelease),
        "Failed to match genes: ENSMUSG00000000000"
    )
    expect_error(
        convertGenesToSymbols(c("ENSMUSG00000000001", NA)),
        "is_non_missing_nor_empty_character :"
    )
    expect_error(
        convertGenesToSymbols(c("ENSMUSG00000000001", "")),
        "is_non_missing_nor_empty_character :"
    )
})



# convertTranscriptsToGenes ====================================================
test_that("convertTranscriptsToGenes : character", {
    x <- c("ENSMUST00000000001", "ENSMUST00000000003")
    y <- c(
        "ENSMUST00000000001" = "ENSMUSG00000000001",
        "ENSMUST00000000003" = "ENSMUSG00000000003"
    )

    # tx2gene (recommended)
    tx2gene <- makeTx2geneFromEnsembl(
        organism = "Mus musculus",
        release = ensemblRelease
    )
    expect_identical(
        convertTranscriptsToGenes(x, tx2gene = tx2gene),
        y
    )

    # organism
    expect_identical(
        convertTranscriptsToGenes(
            x,
            organism = "Mus musculus",
            release = ensemblRelease
        ),
        y
    )

    # No tx2gene or organism
    expect_identical(
        convertTranscriptsToGenes(x, release = ensemblRelease),
        y
    )
})

test_that("convertTranscriptsToGenes : matrix", {
    mat <- matrix(
        data = seq(1L:8L),
        byrow = TRUE,
        nrow = 4L,
        ncol = 2L,
        dimnames = list(
            c(
                "ENSMUST00000000000",
                "ENSMUST00000000001",
                "ENSMUST00000000003",
                "ENSMUST00000114041"
            ),
            c("sample_1", "sample_2")
        )
    )
    expect_error(
        convertTranscriptsToGenes(mat, release = ensemblRelease),
        "Failed to match transcripts: ENSMUST00000000000"
    )
    expect_identical(
        mat[2L:4L, ] %>%
            convertTranscriptsToGenes() %>%
            rownames(),
        c(
            "ENSMUST00000000001" = "ENSMUSG00000000001",
            "ENSMUST00000000003" = "ENSMUSG00000000003",
            "ENSMUST00000114041" = "ENSMUSG00000000003"
        )
    )
})

test_that("convertTranscriptsToGenes : Invalid params", {
    expect_error(
        convertTranscriptsToGenes(
            c("ENSMUST00000000000", "ENSMUST00000000001"),
            release = ensemblRelease
        ),
        "Failed to match transcripts: ENSMUST00000000000"
    )
    expect_error(
        convertTranscriptsToGenes(c("ENSMUSG00000000001", NA)),
        "is_non_missing_nor_empty_character :"
    )
    expect_error(
        convertTranscriptsToGenes(c("ENSMUSG00000000001", "")),
        "is_non_missing_nor_empty_character :"
    )
})



# convertUCSCBuildToEnsembl ====================================================
test_that("convertUCSCBuildToEnsembl", {
    expect_identical(
        convertUCSCBuildToEnsembl("hg19"),
        c(hg19 = "GRCh37")
    )
    expect_identical(
        convertUCSCBuildToEnsembl("hg38"),
        c(hg38 = "GRCh38")
    )
    expect_identical(
        convertUCSCBuildToEnsembl("mm10"),
        c(mm10 = "GRCm38")
    )
    expect_identical(
        convertUCSCBuildToEnsembl("XXX"),
        NULL
    )
})



# detectOrganism ===============================================================
test_that("detectOrganism : Homo sapiens", {
    x <- "Homo sapiens"
    expect_identical(x, detectOrganism("Homo sapiens"))
    expect_identical(x, detectOrganism("hsapiens"))
    expect_identical(x, detectOrganism("GRCh38"))
    expect_identical(x, detectOrganism("grch38"))
    expect_identical(x, detectOrganism("hg38"))
    expect_identical(x, detectOrganism("ENSG00000000001"))
    expect_identical(x, detectOrganism("ENST00000000001"))
})

test_that("detectOrganism : Mus musculus", {
    x <- "Mus musculus"
    expect_identical(x, detectOrganism("Mus musculus"))
    expect_identical(x, detectOrganism("mmusculus"))
    expect_identical(x, detectOrganism("GRCm38"))
    expect_identical(x, detectOrganism("grcm38"))
    expect_identical(x, detectOrganism("mm10"))
    expect_identical(x, detectOrganism("ENSMUSG00000000001"))
    expect_identical(x, detectOrganism("ENSMUST00000000001"))
})

test_that("detectOrganism : Rattus norvegicus", {
    x <- "Rattus norvegicus"
    expect_identical(x, detectOrganism("Rattus norvegicus"))
    expect_identical(x, detectOrganism("rnorvegicus"))
    expect_identical(x, detectOrganism("ENSRNOG00000000001"))
    expect_identical(x, detectOrganism("ENSRNOT00000000001"))
})

test_that("detectOrganism : Danio rerio", {
    x <- "Danio rerio"
    expect_identical(x, detectOrganism("Danio rerio"))
    expect_identical(x, detectOrganism("drerio"))
    expect_identical(x, detectOrganism("GRCz10"))
    expect_identical(x, detectOrganism("danRer10"))
    expect_identical(x, detectOrganism("ENSDARG00000000001"))
    expect_identical(x, detectOrganism("ENSDART00000000001"))
})

test_that("detectOrganism : Drosophila melanogaster", {
    x <- "Drosophila melanogaster"
    expect_identical(x, detectOrganism("Drosophila melanogaster"))
    expect_identical(x, detectOrganism("dmelanogaster"))
    expect_identical(x, detectOrganism("BDGP6"))
    expect_identical(x, detectOrganism("dm6"))
    expect_identical(x, detectOrganism("FBgn0000001"))
    expect_identical(x, detectOrganism("FBtr0000001"))
})

test_that("detectOrganism : Caenorhabditis elegans", {
    x <- "Caenorhabditis elegans"
    expect_identical(x, detectOrganism("Caenorhabditis elegans"))
    expect_identical(x, detectOrganism("celegans"))
    expect_identical(x, detectOrganism("WBcel235"))
    expect_identical(x, detectOrganism("ce11"))
    expect_identical(x, detectOrganism("WBGene00000001"))
})

test_that("detectOrganism : Gallus gallus", {
    x <- "Gallus gallus"
    expect_identical(x, detectOrganism("Gallus gallus"))
    expect_identical(x, detectOrganism("ggallus"))
    expect_identical(x, detectOrganism("ENSGALG00000000001"))
    expect_identical(x, detectOrganism("ENSGALT00000000001"))
})

test_that("detectOrganism : Ovis aries", {
    x <- "Ovis aries"
    expect_identical(x, detectOrganism("Ovis aries"))
    expect_identical(x, detectOrganism("oaries"))
    expect_identical(x, detectOrganism("ENSOARG00000000001"))
    expect_identical(x, detectOrganism("ENSOART00000000001"))
})

test_that("detectOrganism : Multiple organisms", {
    x <- c(
        "ENSG00000000001",
        "ENSG00000000002",
        "ENSMUSG00000000001",
        "ENSMUSG00000000002"
    )
    expect_identical(
        suppressWarnings(detectOrganism(x, unique = FALSE)),
        c(
            "ENSG00000000001" = "Homo sapiens",
            "ENSG00000000002" = "Homo sapiens",
            "ENSMUSG00000000001" = "Mus musculus",
            "ENSMUSG00000000002" = "Mus musculus"
        )
    )
    expect_identical(
        suppressWarnings(detectOrganism(x, unique = TRUE)),
        c("Homo sapiens", "Mus musculus")
    )
    expect_warning(
        detectOrganism(x),
        "Multiple organisms detected"
    )
})

test_that("detectOrganism : Detection failure", {
    expect_error(
        detectOrganism("XXX"),
        "Failed to detect organism"
    )
})

test_that("detectOrganism : matrix", {
    expect_identical(
        detectOrganism(mat),
        "Homo sapiens"
    )
})

test_that("detectOrganism : tbl_df", {
    x <- as(mat, "tbl_df")
    expect_true("rowname" %in% colnames(x))
    expect_identical(
        detectOrganism(x),
        "Homo sapiens"
    )
})



# eggnog =======================================================================
test_that("eggnog", {
    x <- eggnog()
    expect_is(x, "list")
    expect_identical(
        names(x),
        c("cogFunctionalCategories", "annotations")
    )
    expect_identical(
        lapply(x, colnames),
        list(
            cogFunctionalCategories = c(
                "letter",
                "description"
            ),
            annotations = c(
                "eggnogID",
                "consensusFunctionalDescription",
                "cogFunctionalCategory"
            )
        )
    )
})



# emptyRanges ==================================================================
test_that("emptyRanges", {
    x <- emptyRanges("XXX")
    expect_identical(
        levels(seqnames(x)),
        "unknown"
    )
    expect_identical(
        IRanges::ranges(x),
        IRanges::IRanges(
            start = 1L,
            end = 100L,
            names = "XXX"
        )
    )
})

test_that("emptyRanges : mcols", {
    x <- emptyRanges(
        "EGFP",
        seqname = "transgene",
        mcolsNames = c("geneID", "geneName")
    )
    expect_identical(
        names(mcols(x)),
        c("geneID", "geneName")
    )
})



# geneSynonyms =================================================================
test_that("geneSynonyms", {
    lapply(
        X = as.character(formals("geneSynonyms")[["organism"]])[-1L],
        FUN = function(organism) {
            x <- geneSynonyms(organism = organism)
            expect_is(x, "grouped_df")
        }
    )
})



# makeGene2symbolFromEnsembl ===================================================
test_that("makeGene2symbolFromEnsembl", {
    x <- makeGene2symbolFromEnsembl(
        organism = "Homo sapiens",
        release = ensemblRelease
    )
    expect_identical(colnames(x), c("geneID", "geneName"))
    expect_identical(nrow(x), 63970L)
})



# makeGene2symbolFromGFF =======================================================
test_that("makeGene2symbolFromGFF : Minimal GTF", {
    x <- makeGene2symbolFromGFF("example.gtf")
    expect_is(x, "data.frame")
    expect_identical(dim(x), c(17L, 2L))
    expect_identical(
        head(x, 2L),
        data.frame(
            geneID = c("ENSMUSG00000025900", "ENSMUSG00000051951"),
            geneName = c("Rp1", "Xkr4"),
            row.names = c("ENSMUSG00000025900", "ENSMUSG00000051951"),
            stringsAsFactors = FALSE
        )
    )
})

test_that("makeGene2symbolFromGFF : Minimal GFF3", {
    x <- makeGene2symbolFromGFF("example.gff3")
    expect_is(x, "data.frame")
    expect_identical(dim(x), c(20L, 2L))
    expect_identical(
        head(x, 2L),
        data.frame(
            geneID = c("ENSMUSG00000025900", "ENSMUSG00000025902"),
            geneName = c("Rp1", "Sox17"),
            row.names = c("ENSMUSG00000025900", "ENSMUSG00000025902"),
            stringsAsFactors = FALSE
        )
    )
})



# makeGRangesFromEnsembl =======================================================
test_that("makeGRangesFromEnsembl : genes", {
    x <- makeGRangesFromEnsembl(
        organism = "Homo sapiens",
        format = "genes",
        release = ensemblRelease
    )
    expect_s4_class(x, "GRanges")
    expect_identical(length(x), 63970L)
    expect_identical(
        head(names(x), 3L),
        c("ENSG00000000003", "ENSG00000000005", "ENSG00000000419")
    )
    expect_identical(
        lapply(mcols(x), class),
        list(
            broadClass = "factor",
            description = "factor",
            entrezID = "list",
            geneBiotype = "factor",
            geneID = "character",
            geneName = "factor",
            seqCoordSystem = "factor"
        )
    )
})

test_that("makeGRangesFromEnsembl : transcripts", {
    x <- makeGRangesFromEnsembl(
        organism = "Homo sapiens",
        format = "transcripts",
        release = ensemblRelease
    )
    expect_s4_class(x, "GRanges")
    expect_identical(length(x), 216741L)
    expect_identical(
        head(names(x), 3L),
        c("ENST00000000233", "ENST00000000412", "ENST00000000442")
    )
    expect_identical(
        lapply(mcols(x), class),
        list(
            broadClass = "factor",
            description = "factor",
            entrezID = "list",
            geneBiotype = "factor",
            geneID = "factor",
            geneName = "factor",
            seqCoordSystem = "factor",
            transcriptBiotype = "factor",
            transcriptCdsSeqEnd = "integer",
            transcriptCdsSeqStart = "integer",
            transcriptID = "character",
            transcriptName = "character",
            transcriptSupportLevel = "integer"
        )
    )
})

test_that("makeGRangesFromEnsembl : GRCh37", {
    # genes
    x <- makeGRangesFromEnsembl(
        organism = "Homo sapiens",
        format = "genes",
        build = "GRCh37"
    )
    expect_is(x, "GRanges")
    expect_identical(length(x), 64102L)
    expect_identical(head(names(x), 1L), "ENSG00000000003")

    # transcripts
    x <- makeGRangesFromEnsembl(
        organism = "Homo sapiens",
        format = "transcripts",
        build = "GRCh37"
    )
    expect_is(x, "GRanges")
    expect_identical(length(x), 215647L)
    expect_identical(head(names(x), 1L), "ENST00000000233")
})

test_that("makeGRangesFromEnsembl : Invalid parameters", {
    expect_error(
        makeGRangesFromEnsembl("Homo sapiens", build = "hg38"),
        "UCSC build ID detected."
    )
    expect_warning(
        makeGRangesFromEnsembl("Homo sapiens", release = 86L),
        "Switching to current release instead."
    )
    expect_error(
        makeGRangesFromEnsembl(organism = "AAA", build = "BBB"),
        "No ID matched on AnnotationHub"
    )
    expect_error(
        makeGRangesFromEnsembl(c("Homo sapiens", "Mus musculus")),
        "is_a_string : "
    )
    expect_error(
        makeGRangesFromEnsembl("Homo sapiens", format = "XXX"),
        "'arg' should be one of \"genes\", \"transcripts\""
    )
})

test_that("makeGRangesFromEnsembl : metadata", {
    x <- makeGRangesFromEnsembl(
        organism = "Homo sapiens",
        release = ensemblRelease,
        metadata = TRUE
    )
    expect_is(x, "list")
    expect_identical(
        names(x),
        c("data", "metadata")
    )
    expect_is(x[["metadata"]], "tbl_df")
})



# makeGRangesFromGFF ===========================================================
test_that("makeGRangesFromGFF : Minimal GTF", {
    # Genes
    x <- makeGRangesFromGFF("example.gtf", format = "genes")
    expect_s4_class(x, "GRanges")
    expect_identical(length(x), 17L)
    expect_identical(names(x)[[1L]], "ENSMUSG00000025900")
    expect_identical(
        lapply(mcols(x), class),
        list(
            broadClass = "factor",
            geneBiotype = "factor",
            geneID = "character",
            geneName = "character",
            geneSource = "factor",
            geneVersion = "factor",
            source = "factor",
            type = "factor"
        )
    )

    # Transcripts
    x <- makeGRangesFromGFF("example.gtf", format = "transcripts")
    expect_s4_class(x, "GRanges")
    expect_identical(length(x), 20L)
    expect_identical(names(x)[[1L]], "ENSMUST00000070533")
    expect_identical(
        lapply(mcols(x), class),
        list(
            broadClass = "factor",
            ccdsID = "factor",
            geneBiotype = "factor",
            geneID = "factor",
            geneName = "factor",
            geneSource = "factor",
            geneVersion = "factor",
            source = "factor",
            tag = "factor",
            transcriptBiotype = "factor",
            transcriptID = "character",
            transcriptName = "character",
            transcriptSource = "factor",
            transcriptSupportLevel = "factor",
            transcriptVersion = "factor",
            type = "factor"
        )
    )
})

test_that("makeGRangesFromGFF : Minimal GFF3", {
    # Genes
    x <- makeGRangesFromGFF("example.gff3", format = "genes")
    expect_s4_class(x, "GRanges")
    expect_identical(length(x), 20L)
    expect_identical(names(x)[[1L]], "ENSMUSG00000025900")
    expect_identical(
        lapply(mcols(x), class),
        list(
            broadClass = "factor",
            description = "character",
            geneBiotype = "factor",
            geneID = "character",
            geneName = "character",
            havanaGene = "factor",
            havanaVersion = "factor",
            logicName = "factor",
            source = "factor",
            type = "factor",
            version = "factor"
        )
    )

    # Transcripts
    x <- makeGRangesFromGFF("example.gff3", format = "transcripts")
    expect_s4_class(x, "GRanges")
    expect_identical(length(x), 26L)
    expect_identical(names(x)[[1L]], "ENSMUST00000027032")
    expect_identical(
        lapply(mcols(x), class),
        list(
            broadClass = "factor",
            ccdsID = "factor",
            geneBiotype = "factor",
            geneID = "factor",
            geneName = "factor",
            havanaTranscript = "factor",
            havanaVersion = "factor",
            source = "factor",
            tag = "factor",
            transcriptBiotype = "factor",
            transcriptID = "character",
            transcriptName = "character",
            transcriptSupportLevel = "factor",
            type = "factor",
            version = "factor"
        )
    )
})



# makeTx2geneFromEnsembl =======================================================
test_that("makeTx2geneFromEnsembl", {
    x <- makeTx2geneFromEnsembl(
        organism = "Homo sapiens",
        release = ensemblRelease
    )
    expect_identical(colnames(x), c("transcriptID", "geneID"))
    expect_identical(nrow(x), 216741L)
})



# makeTx2geneFromGFF ===========================================================
test_that("makeTx2geneFromGFF : Minimal GTF", {
    x <- makeTx2geneFromGFF("example.gtf")
    expect_is(x, "data.frame")
    expect_identical(dim(x), c(20L, 2L))
    expect_identical(
        head(x, 2L),
        data.frame(
            transcriptID = c("ENSMUST00000070533", "ENSMUST00000082908"),
            geneID = c("ENSMUSG00000051951", "ENSMUSG00000064842"),
            row.names = c("ENSMUST00000070533", "ENSMUST00000082908"),
            stringsAsFactors = FALSE
        )
    )
})

test_that("makeTx2geneFromGFF : Minimal GFF3", {
    x <- makeTx2geneFromGFF("example.gff3")
    expect_is(x, "data.frame")
    expect_identical(dim(x), c(26L, 2L))
    expect_identical(
        head(x, 2L),
        data.frame(
            transcriptID = c("ENSMUST00000027032", "ENSMUST00000027035"),
            geneID = c("ENSMUSG00000025900", "ENSMUSG00000025902"),
            row.names = c("ENSMUST00000027032", "ENSMUST00000027035"),
            stringsAsFactors = FALSE
        )
    )
})



# PANTHER ======================================================================
test_that("PANTHER", {
    organisms <- c(
        "Homo sapiens",
        "Mus musculus",
        "Drosophila melanogaster",
        "Caenorhabditis elegans"
    )
    list <- lapply(organisms, function(organism) {
        invisible(capture.output(
            x <- panther(organism)
        ))
        expect_is(x, "data.frame")
    })
})



# stripTranscriptVersions ======================================================
test_that("stripTranscriptVersions : character", {
    expect_identical(
        stripTranscriptVersions("ENSMUST00000119854.7"),
        "ENSMUST00000119854"
    )
    # Return unmodified if not Ensembl transcript (ENS*T)
    expect_identical(
        stripTranscriptVersions("EGFP.1"),
        "EGFP.1"
    )
    # Theoretical spike-in containing a transcript version
    expect_identical(
        stripTranscriptVersions(c("ENSMUST00000119854.7", "EGFP.1")),
        c("ENSMUST00000119854", "EGFP.1")
    )
})

test_that("stripTranscriptVersions : matrix", {
    x <- mat
    rownames(x) <- c(
        "ENSMUST00000000001.1",
        "ENSMUST00000000001.2",
        "ENSMUST00000000002.1",
        "EGFP.1"
    )
    y <- stripTranscriptVersions(x)
    expect_identical(
        rownames(y),
        c(
            "ENSMUST00000000001",
            "ENSMUST00000000001",  # allowed in matrix
            "ENSMUST00000000002",
            "EGFP.1"
        )
    )
})
