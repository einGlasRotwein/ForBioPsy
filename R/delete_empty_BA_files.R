
#' Delete empty data and marker files
#'
#' @param filetype A character vector specifying the file types that should be
#'                 considered. Can be set to "txt", "dat" and/or "csv".
#'                 Defaults to all of these types.
#' @param folderpath The path of the folder you want to delete empty files in.
#'                   If none is provided, the current working directory is
#'                   searched.
#' @param header Does the first non-skipped line contain a header? Defaults to
#'               \code{TRUE}.
#' @param sep What is the separator in your files? Defaults to \code{""}.
#' @param skip Indicate how many lines should be skipped in your files because
#'             the header e.g. starts in line 2. Be aware that you might have to
#'             run the function multiple times with different inputs when your
#'             data varies in structure and have a different amount of lines to
#'             skip. Defaults to 0.
#' @param row.names Should row names be used? Defaults to \code{NULL}.
#' @param only_truly_empty Logical. Indicates if only files that are truly empty
#'                         (i.e. have a file size of 0 or are completely blank)
#'                         should be deleted or if additionally, files that just
#'                         contain column names (but no additional data) should
#'                         be deleted as well. Defaults to \code{FALSE}.
#' @param ... Additional arguments passed to \code{read.table()}, which is
#'            called to check if files contain empty lines. Might lead to
#'            unexpected results.
#'
#' @details Originally, \code{delete_empty_BA_files()} is designed to clean up
#'          data exported from the
#'          \href{https://www.brainproducts.com/downloads.php?kid=9}{Brain Vision Analyzer}.
#'          In principle, however, it can be used to delete any empty .txt, .dat
#'          or .csv files in a given folder.
#'
#'          Sometimes, data exported from the Brain Vision Analyzer contains
#'          column names, but no actual data. By default, those are deleted as
#'          well, but you can restrict the deletion of files to those that are
#'          truly empty by setting \code{only_truly_empty = TRUE}. This will
#'          only delete files that either have a file size of 0 or are "blank",
#'          i.e. contain neither data nor a header or text. Note that the
#'          approach with \code{only_truly_empty = TRUE} relying on file
#'          size = 0 only really works for .txt files, because empty .csv and
#'          .dat files also have a small size. Instead,
#'          \code{delete_empty_files()} will try to open those files and if it
#'          encounters an error because they are empty, it will delete them. I
#'          cannot guarantee that this will lead to unexpected results at some
#'          point, but I'd always advise to backup your files before
#'          automatically and permanently deleting stuff anyways. Also note that
#'          of course, if you skip all the data with the \code{skip} argument
#'          and only empty lines follow afterwards, the file will be considered
#'          empty as well.
#'
#'          In some cases, your exported files contain additional information in
#'          the first line and column names only start in the following lines.
#'          You can skip lines that contain irrelevant information via the
#'          argument \code{skip}.
#'
#'          Examples without any example files aren't of much use here, so head
#'          to the example folder on
#'          \href{https://github.com/einGlasRotwein/ForBioPsy}{GitHub} to see
#'          the function in action.
#'
#' @author Juliane Tkotz \email{juliane.tkotz@@hhu.de}
#' @export
#'

delete_empty_BA_files <- function(filetype = c("txt", "csv", "dat"),
                                  folderpath = ".", header = TRUE, sep = "",
                                  skip = 0, row.names = NULL,
                                  only_truly_empty = FALSE, ...) {
  validate_input(folderpath, "folderpath", "character", 1)
  validate_input(filetype, "filetype", "character", input_set = c("txt", "csv", "dat"))

  pattern <- paste0("\\.", filetype, "$", collapse = "|")
  file_paths <- list.files(folderpath, pattern = pattern, full.names = TRUE)

  # Delete files that are COMPLETELY empty
  info <- file.info(file_paths)
  empty <- rownames(info[info$size == 0, ])
  invisible(sapply(empty, unlink))

  # Delete files with size = 0
  if (length(empty) != 0) {
    file_paths <- list.files(folderpath, pattern = pattern, full.names = TRUE)
  }

  # Delete files that have a size > 0, but are blank
  invisible(
    sapply(
      file_paths,
      function(x) {
        try_info <- try(read.table(x, skip = skip, header = header, sep = sep,
                                   row.names = row.names, ...), silent = TRUE)
        if (grepl("empty", try_info[1], fixed = TRUE) |
            grepl("no lines", try_info[1], fixed = TRUE)) {
          unlink(x)
        }
      }
    )
  )

  file_paths <- list.files(folderpath, pattern = pattern, full.names = TRUE)

  # Delete files that contain a header, but no data
  if (!only_truly_empty) {
    invisible(
      sapply(
        file_paths,
        function(x) {
          try_info <- try(
            cur_markerfile <- read.table(x, skip = skip, header = header,
                                         sep = sep, row.names = row.names, ...),
            silent = TRUE
            )
          if (grepl("did not have", try_info[1], fixed = TRUE)) {
            stop("Whoops. Seems like there is something wrong with your header or separator.")
          }

          if (nrow(cur_markerfile) == 0) {
            unlink(x)
          }
        }
      )
    )
  }
}
