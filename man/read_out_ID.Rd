% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read_out_ID.R
\name{read_out_ID}
\alias{read_out_ID}
\title{Read out participant IDs of a specified format from filenames}
\usage{
read_out_ID(ID_format, folderpath = ".", filenames = FALSE,
  remove_ = TRUE, ...)
}
\arguments{
\item{ID_format}{The way the participant ID is structured. See details.}

\item{folderpath}{A (vector of) character string(s) of the folder path(s) you
want to extract participant IDs from. If none is provided,
the current working directory is searched. You can also
just pass a (vector of) file name(s).}

\item{filenames}{Do you want to get the filenames that contain valid IDs
rather than just the IDs? Defaults to \code{FALSE}.}

\item{remove_}{When the ID is separated from the actual file name with an
underscore (i.e. if \code{ID_format} ends with an underscore),
it gets removed in the output. If you want to keep an
underscore at the end of each participant's ID, you can
prevent this behaviour by setting \code{remode_} to
\code{FALSE}. Defaults to \code{TRUE}.}

\item{...}{Additional arguments for \code{list.files()}, if \code{folderpath}
contains (a) folder path(s).}
}
\description{
Read out participant IDs of a specified format from filenames
}
\details{
When you have consistent file names that start with a participant ID
         (or a number followed by an underscore and a participant ID),
         \code{read_out_ID()} will extract it for you. It will either take
         into account all files in a given folder (path passed in
         \code{folderpath}) or a (vector of) single file name(s).

         You need to specify the format the IDs have via \code{ID_format}.
         That is, you give an example where "X" is a letter and "0" is a
         digit. And _ is an underscore. For example, when your participant
         IDs look like "JD_29MM" or "JT_03KD", you'd type in "XX_00XX". X can
         stand for an upper or lower case letter.

         Because you can directly run them from your console, the examples in
         this documentation only work with file names. However, if you'd like
         to see examples with a folder (path), head to the example folder on
         \href{https://github.com/einGlasRotwein/ForBioPsy}{GitHub}.
}
\examples{
my_files <- c("LF00AP_data.txt", "JT13MP_data.txt", "MT99KD_data.txt",
              "dont_catch_me.txt")
read_out_ID("XX00XX_", my_files)

read_out_ID("XX00XX_", my_files, remove_ = FALSE)
read_out_ID("XX00XX_", my_files, filenames = TRUE)

}
\author{
Juliane Tkotz \email{juliane.tkotz@hhu.de}
}
