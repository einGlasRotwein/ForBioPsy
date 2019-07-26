#' A function for input validation
#'
#' @param obj The object that undergoes validation
#' @param argument_name A string indicating the name of the object
#'   This name is used when an error is thrown so the user
#' @param class_string A character vector of legal classes. If
#'   \code{class_string} is "numeric", it will be expanded to
#'   c("numeric", "integer", "double"). The class is tested via the
#'   function \code{class}. This means that if \code{obj} is a matrix,
#'   it is necessary to pass \code{class_string = "matrix"}; you cannot
#'   refer to the "mode" of the matrix. A special case is the
#'   \code{class_string} "groupvar" that is expanded to
#'   c("factor", "character", "numeric", "integer", "double").
#' @param len Optional numeric vector for objects having a length
#'   (mostly for vectors).
#' @param gt0 Optional logical vector indicating if numeric input has
#'   to be greater than 0.
#' @param groupsize Optional argument how many groups a grouping variable
#'   consist of.
#' @param input_set Optional argument specifying a set of values an
#'   argument can take.
#'
#' @return NULL
#'
#' @details Taken from the package \code{prmisc} by Martin Papenberg, with
#'          slight adaptations.
#'
#' @author Martin Papenberg \email{martin.papenberg@@hhu.de}
#'
#' @noRd

validate_input <- function(obj, argument_name, class_string = NULL, len = NULL,
                           gt0 = FALSE, groupsize = NULL, input_set = NULL) {

  self_validation(argument_name, class_string, len, gt0, groupsize, input_set)

  ## - Check class of object
  if (argument_exists(class_string))  {
    # Allow for all numeric types:
    if ("numeric" %in% class_string) {
      class_string <- c(class_string, "integer", "double")
    }
    # Case - grouping variable: Allow for numeric, character or factor
    if ("groupvariable" %in% class_string) {
      class_string <- setdiff(c(class_string, "factor", "ordered", "character",
                                "numeric", "integer", "double", "logical"),
                              "groupvariable")
    }
    # Special case integer: It's class may be integer or numeric
    if (class_string[1] == "integer") {
      correct_class <- class(obj)[1] %in% c("numeric", "integer")
      if (!correct_class){
        stop(argument_name, " must be integer")
      }

      if (any(obj %% 1 != 0)) {
        stop(argument_name, " must be integer")
      }
    } else {
      correct_class <- class(obj)[1] %in% class_string
      if (!correct_class) {
        stop(argument_name, " must be of class '",
             paste(class_string, collapse = "' or '"), "'")
      }
    }
  }

  ## - Check length of input
  if (argument_exists(len)) {
    if (length(obj) != len) {
      stop(argument_name, " must have length ", len)
    }
  }

  ## - Check if input has to be greater than 0
  if (gt0 == TRUE && any(obj <= 0)) {
    stop(argument_name, " must be greater than 0")
  }

  ## - Check if correct number of groups is provided
  if (argument_exists(groupsize)) {
    if (length(table(obj)[table(obj) != 0]) != groupsize) {
      stop(argument_name, " must consist of exactly ", groupsize,
           " groups with more than 0 observations.")
    }
  }

  ## - Check if argument matches a predefined input set
  if (argument_exists(input_set)) {
    if (argument_exists(len)){
      if (len == 1 && (!obj %in% input_set)) {
        stop(argument_name, " can either be set to one of '",
             paste(input_set, collapse = "' or '"), "'")
      }
    }
    if (any(!obj %in% input_set)) {
      stop(argument_name, " can only be set to one or more values of the following set: '",
           paste(input_set, collapse = "' , '"), "'")
    }
  }

  return(invisible(NULL))
}

self_validation <- function(argument_name, class_string, len, gt0, groupsize,
                            input_set) {
  if (argument_exists(class_string)) {
    stopifnot(class(class_string) == "character")
    stopifnot(class(argument_name) == "character")
  }
  if (argument_exists(len)) {
    stopifnot(class(len) %in% c("numeric", "integer"))
    stopifnot(length(len) == 1)
    stopifnot(len >= 0)
    stopifnot(len %% 1 == 0)
  }
  stopifnot(class(gt0) == "logical")
  stopifnot(length(gt0) == 1)

  if (argument_exists(groupsize)) {
    stopifnot(mode(groupsize) == "numeric")
    stopifnot(length(groupsize) == 1)
  }

  return(invisible(NULL))
}

argument_exists <- function(arg) {
  !is.null(arg)
}
