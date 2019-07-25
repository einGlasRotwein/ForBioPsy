
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
av_chicks <- ChickWeight %>%
  group_by(Time, Diet) %>%
  summarise(weight = mean(weight))

# A simple Plot tracking the chicks' weight over time between diets
ggplot() +
  geom_line(data = av_chicks, aes(x = Time, y = weight, colour = Diet)) +
  chick_theme

# Let's add shading for three intervals: 5 - 10; 10.5 - 12; 16 - 19
# We call them phase 1, 2 and 3, but usually, you'd have EEG components here
library(ForBioPsy)

shading <- shade_components(components = c("phase 1", "phase 2", "phase 3"),
                            durations = c("5 - 10", "10.5 - 12", "16 - 19"))

# The function should have printed:

# Component shading generated.
#
# Please add the following lines to your plot and replace 'YOURDF' with the
# object you saved this function's output in:
#
# geom_rect(data = 'YOURDF', aes(xmin = xstart, xmax = xend, ymin = -Inf,
# ymax = Inf, fill = component), alpha = .5) +
# scale_fill_manual('component', values = c('#E3E3E3', '#C8C6C6', '#E3E3E3'))

# So we replace 'YOURDF' with shading and add it to our plot.
# Don't forget the all the + you need and mind that you place the shading
# before (e.g. below) the data you plot (the lines). Also note that our geoms
# draw on different data and mapping, so if you put the av_chicks data into
# ggplot() already, it will get "lost" on the way.

ggplot() +
  geom_rect(data = shading,
            aes(xmin = xstart, xmax = xend, ymin = -Inf, ymax = Inf,
                fill = component), alpha = .5) +
  scale_fill_manual('component', values = c('#E3E3E3', '#C8C6C6', '#E3E3E3')) +
  geom_line(data = av_chicks, aes(x = Time, y = weight, colour = Diet)) +
  chick_theme

# You might want to break your legend down like this:
ggplot() +
  geom_rect(data = shading,
            aes(xmin = xstart, xmax = xend, ymin = -Inf, ymax = Inf,
                fill = component), alpha = .5) +
  scale_fill_manual('component', values = c('#E3E3E3', '#C8C6C6', '#E3E3E3')) +
  geom_line(data = av_chicks, aes(x = Time, y = weight, colour = Diet)) +
  guides(fill = guide_legend(nrow = 2), colour = guide_legend(nrow = 2)) +
  chick_theme
