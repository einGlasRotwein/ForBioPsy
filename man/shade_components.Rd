% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/shade_components.R
\name{shade_components}
\alias{shade_components}
\title{Generate a dataframe and geoms to shade components of an EEG plot}
\usage{
shade_components(components, durations)
}
\arguments{
\item{components}{A character vector with the components' names.}

\item{durations}{A character vector giving the components' durations. See
details for correct format.}
}
\description{
Generate a dataframe and geoms to shade components of an EEG plot
}
\details{
The main output of the function is a dataframe that contains all the
         information needed to shade the areas of your EEG components.
         Simultaneously, \code{shade_components()} will print the code you
         need to add to your plot to insert your newly created component
         shading. Note that you need to replace \code{'YOURDF'} with the name
         of the object you saved the function's output to. Make sure you add
         \code{geom_rect()} before your other \code{geoms} so the shading
         lies below the data you're plotting. Don't forget to add \code{+}
         before and/or after the additional lines if needed. Also note that
         a specific order of \code{geoms} in your plot may be required, as
         well as certain requirements how to pass your data to
         \code{ggplot()}. See the example folder on
         \href{https://github.com/einGlasRotwein/ForBioPsy}{GitHub} for
         clarification.

         You provide the durations as a character vector, such as e.g.
         \code{c("400 - 500", "500 - 700")}. See examples.

         As you can tell from this printed output, what you get is a
         combination of \code{geom_rect()} and \code{scale_fill_manual()}
         (for specifying colours). Note that \code{scale_fill_manual()} might
         interfere with other fill colouring you might have set. Depending on
         what theme you use, you might need to change the default colours of
         the shading. It's (two alternating) shades of grey - which is not
         everyones taste. And crucially, won't work for every plot. Go ahead
         and replace the colours  with e.g. hex colour code or colour names
         (see a list
         \href{http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf}{here}).
         Alternatively, you could try and add
         \code{theme(panel.background = element_blank())} to get rid of the
         panel background - or try a different \pkg{ggplot2}
         \href{https://ggplot2.tidyverse.org/reference/ggtheme.html}{theme}.
}
\examples{

library(tidyverse)
# Theme I want for my plot
chick_theme <- theme(legend.position = "top",
                     axis.title = element_text(size = 14),
                     axis.text = element_text(size = 12),
                     legend.text = element_text(size = 12),
                     legend.title = element_text(size = 14),
                     panel.background = element_blank(),
                     panel.grid.major = element_line(colour = "light grey"),
                     panel.grid.minor.x = element_blank(),
                     panel.grid.minor.y = element_line(colour = "light grey"))

# Example with the ChickWeight dataset
chicks <- ChickWeight

# Average across chicks
av_chicks <- ChickWeight \%>\%
group_by(Time, Diet) \%>\%
summarise(weight = mean(weight))

library(ForBioPsy)
shading <- shade_components(components = c("phase 1", "phase 2", "phase 3"),
                            durations = c("5 - 10", "10.5 - 12", "16 - 19"))

# Note the console
ggplot() +
  geom_rect(data = shading,
            aes(xmin = xstart, xmax = xend, ymin = -Inf, ymax = Inf,
            fill = component), alpha = .5) +
  scale_fill_manual('component', values = c('#E3E3E3', '#C8C6C6', '#E3E3E3')) +
  geom_line(data = av_chicks, aes(x = Time, y = weight, colour = Diet)) +
  chick_theme

}
\author{
Juliane Tkotz \email{juliane.tkotz@hhu.de}
}
