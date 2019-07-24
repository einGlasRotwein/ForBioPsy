
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
av_chicks %>%
  ggplot(aes(x = Time, y = weight)) +
  geom_line(aes(colour = Diet)) +
  chick_theme

# Let's add auxiliary axes at Time = 10 and weight = 150 for absolutely no
# reason
library(ForBioPsy)

x_ticks <- generate_shifted_axis(
  limits = c(0, 20), steps = 5, other_ax_steps = 50,
  axis = "x", intercept = 150
)

# The function should have printed:

# x-axis generated.
#
# Please add the following geoms to your plot and replace 'YOURDF' with the
# object you saved this function's output in:
#
# geom_hline(yintercept = 150) +
# geom_segment(data = 'YOURDF', aes(x = ticks, y = intercept - tick_sz * .5,
# xend = ticks, yend = intercept + tick_sz * .5))

# So we replace 'YOURDF' with x_ticks and add it to our plot.
# Don't forget the + in the line before and mind that colour = Diet NEEDS to be
# in geom_line, because if already passed in ggplot(), ggplot2 will try and
# apply the grouping variable to our newly added geoms, which won't work.

av_chicks %>%
  ggplot(aes(x = Time, y = weight)) +
  geom_line(aes(colour = Diet)) +
  chick_theme +
  geom_hline(yintercept = 150) +
  geom_segment(data = x_ticks,
               aes(x = ticks, y = intercept - tick_sz * .5,
                   xend = ticks, yend = intercept + tick_sz * .5))

# Now for the y-axis
y_ticks <- generate_shifted_axis(
  limits = c(100, 200), steps = 100, other_ax_steps = 5,
  axis = "y", intercept = 10
)

# Prints:

# y-axis generated.
#
# Please add the following geoms to your plot and replace 'YOURDF' with the
# object you saved this function's output in:
#
# geom_vline(xintercept = 10) +
# geom_segment(data = 'YOURDF', aes(x = intercept - tick_sz * .5, y = ticks,
# xend = intercept + tick_sz * .5, yend = ticks))

# We do as it tells us:
av_chicks %>%
  ggplot(aes(x = Time, y = weight)) +
  geom_line(aes(colour = Diet)) +
  chick_theme +
  geom_hline(yintercept = 150) +
  geom_segment(data = x_ticks,
               aes(x = ticks, y = intercept - tick_sz * .5,
                   xend = ticks, yend = intercept + tick_sz * .5)) +
  geom_vline(xintercept = 10) +
  geom_segment(data = y_ticks,
               aes(x = intercept - tick_sz * .5, y = ticks,
                   xend = intercept + tick_sz * .5, yend = ticks))
