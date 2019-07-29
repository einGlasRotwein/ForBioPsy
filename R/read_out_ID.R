
#' Read out participant IDs of a specified format from filenames
#'
#' @param ID_format The way the participant ID is structured. See details.
#' @param folderpath A (vector of) character string(s) of the folder path(s) you
#'                   want to extract participant IDs from. If none is provided,
#'                   the current working directory is searched. You can also
#'                   just pass a (vector of) file name(s).
#' @param filenames Do you want to get the filenames that contain valid IDs
#'                  rather than just the IDs? Defaults to \code{FALSE}.
#' @param remove_ When the ID is separated from the actual file name with an
#'                underscore (i.e. if \code{ID_format} ends with an underscore),
#'                it gets removed in the output. If you want to keep an
#'                underscore at the end of each participant's ID, you can
#'                prevent this behaviour by setting \code{remode_} to
#'                \code{FALSE}. Defaults to \code{TRUE}.
#' @param ... Additional arguments for \code{list.files()}, if \code{folderpath}
#'            contains (a) folder path(s).
#'
#' @details When you have consistent file names that start with a participant ID
#'          (or a number followed by an underscore and a participant ID),
#'          \code{read_out_ID()} will extract it for you. It will either take
#'          into account all files in a given folder (path passed in
#'          \code{folderpath}) or a (vector of) single file name(s).
#'
#'          You need to specify the format the IDs have via \code{ID_format}.
#'          That is, you give an example where "X" is a letter and "0" is a
#'          digit. And _ is an underscore. For example, when your participant
#'          IDs look like "JD_29MM" or "JT_03KD", you'd type in "XX_00XX". X can
#'          stand for an upper or lower case letter.
#'
#'          Because you can directly run them from your console, the examples in
#'          this documentation only work with file names. However, if you'd like
#'          to see examples with a folder (path), head to the example folder on
#'          \href{https://github.com/einGlasRotwein/ForBioPsy}{GitHub}.
#'
#' @examples
#' my_files <- c("LF00AP_data.txt", "JT13MP_data.txt", "MT99KD_data.txt",
#'               "dont_catch_me.txt")
#' read_out_ID("XX00XX_", my_files)
#'
#' read_out_ID("XX00XX_", my_files, remove_ = FALSE)
#'
#' @author Juliane Tkotz \email{juliane.tkotz@@hhu.de}
#' @export
#'

read_out_ID <- function(ID_format, folderpath = ".", filenames = FALSE,
                        remove_ = TRUE, ...) {
  validate_input(folderpath, "folderpath", "character")
  validate_input(ID_format, "ID_format", "character", len = 1)
  validate_input(filenames, "filenames", "logical", len = 1)
  validate_input(remove_, "remove_", "logical", len = 1)

  if (!grepl("^[X0_]*$", ID_format)) {
    stop("ID_format must only consist of X, 0 and _")
  }

  if (any(grepl("/", folderpath)) | any(grepl("^[.]*$", folderpath))) {
    if (!all(grepl("/", folderpath[!folderpath == "."]))) {
      stop("folderpath must contain either only folder paths or file names, not both")
    }
    files <- list.files(folderpath, ...)

    # When recursive = TRUE has been used, we need to cut out the file names
    # after /
    if (any(grepl("/", files))) {
      files <- sub("^.*/", "", files)
    }

  } else {
    files <- folderpath
  }

  expr <- unlist(strsplit(ID_format, ""))
  for (i in seq_along(expr)) {
    if (expr[i] == "0") expr[i] <- "[0-9]"
    if (expr[i] == "X") expr[i] <- "[a-zA-Z]"
    if (expr[i] == "_") expr[i] <- "_"
  }

  if (filenames) {
    starts_with_ID <- paste0(c("^", expr), collapse = "")
    files <- files[grepl(starts_with_ID, files)]
    return(files)
  }

  anything_after <- paste0(c("^(", expr, ").*$"), collapse = "")
  only_ID <- paste0(c("^", expr, "$"), collapse = "")
  # Delete anything after ID
  part_IDs <- sub(anything_after, "\\1", files)
  # When filename isn't matched by ID format, it's left unaltered; throw out
  # those which still aren't in the specified format
  part_IDs <- unique(part_IDs[grepl(only_ID, part_IDs)])

  if (remove_) {
    part_IDs <- sub("_$", "", part_IDs)
  }

  return(part_IDs)
}
