% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/generate_shifted_axis.R
\name{generate_shifted_axis}
\alias{generate_shifted_axis}
\title{Generate a dataframe and geoms to add an auxiliary axis to a plot}
\usage{
generate_shifted_axis(limits, steps, other_ax_steps, axis, tick_sz = 0.7,
  intercept = 0)
}
\arguments{
\item{limits}{A vector with two elements defining the limits of your axis.}

\item{steps}{A single integer or double specifying how far the ticks of the
new auxiliary axis should be apart, in the unit of the axis.}

\item{other_ax_steps}{A single integer or double specifying the how far the
ticks of the orthogonal axis are apart, in the unit of
the orthogonal axis. Is used to determine the size of
the ticks. See details.}

\item{axis}{A character indicating which axis should be generated. Can be set
to "x" or "y".}

\item{tick_sz}{Determines the size of the ticks, which is expressed as
percentage of the other axis's steps. Defaults to .7.
See details.}

\item{intercept}{A single integer or double specifying where the new
auxiliary axis should cross the orthogonal axis, in units of
the orthogonal axis. Defaults to 0.}
}
\description{
Generate a dataframe and geoms to add an auxiliary axis to a plot
}
\details{
The main output of the function is a dataframe that contains all the
         information needed to build an auxiliary axis with tick marks for
         your plot which cross the orthogonal axis at a specified intercept.
         Simultaneously, \code{generate_shifted_axis()} will print the code
         you need to add to your plot to insert your newly created auxiliary
         axis. Note that you need to replace \code{'YOURDF'} with the name of
         the object you saved the function's output to.

         As you can tell from this printed output, it is not a true axis that
         is created, but instead a combination of \code{geom_hline}
         (or \code{geom_vline}) and \code{geom_segment} to mimic an axis. You
         may want to add \code{theme(axis.line = element_blank())} or even
         \code{theme(axis.line = element_blank(), axis.ticks = element_blank())}
         to your plot to get rid of the usual axis lines.

         Note that the axis text is not shifted, but stays with the actual
         axis, because the function is optimised for readable EEG plots. See
         the example folder on
         \href{https://github.com/einGlasRotwein/ForBioPsy}{GitHub}.

         As the ticks are in fact plotted with x and y coordinates, the tick
         size is computed relative to the size of the steps you auxiliary
         axis is orthogonal to. That is, if you are creating a y-axis, the
         ticks of your x-axis are spaced 200 units apart and \code{tick_sz}
         is set to 1, the ticks will be exactly as long as the space between
         two ticks of the x-axis.

         Currently, this \code{generate_shifted_axis()} assumes that both of
         your axes are numerical and is at an experimental stage. Feeding it
         with anything that widely differs from plots roughly resembling an
         EEG data plot or twisting the limits so they don't correspond to
         your plot's actual parameters may lead to quirky results.
}
\examples{

x_ticks <- generate_shifted_axis(
  c(-200, 1100), 200, 1, "x"
  )

}
\author{
Juliane Tkotz \email{juliane.tkotz@hhu.de}
}
