# Documentation
Find current issues and a to do in this README. See current changes in the [NEWS
file](https://github.com/einGlasRotwein/ForBioPsy/tree/master/news%20and%20examples/NEWS.md). Even though this package is primarily designed to match the needs of EEG data analysis, all my examples use the not-so-EEG [chick weight data set](https://www.rdocumentation.org/packages/datasets/versions/3.6.1/topics/ChickWeight), because that's easier to reproduce. But hey. Brain waves. Chick weights. What's the difference, really?

## File Administration
### delete_empty_BA_files()
Meant to delete empty or pseudo-empty export files exported from the [Brain Vision Analyzer](https://www.brainproducts.com/downloads.php?kid=9), but can in principle be used for any .txt, .dat or .csv files that (are supposed to) contain data tables. Will go through a given folder and delete files that are empty/blank or contain nothing but a header. See possible specifications - and the function in full action - in the [example folder](https://github.com/einGlasRotwein/ForBioPsy/tree/master/news%20and%20examples/Examples), where dummy files are provided as well.

## Plotting Functions
### shade_components()
Generate a dataframe and the lines of code to add to `ggplot()` in order to shade the areas of your plot representing components. The main output of the function is a dataframe that contains all the information needed to shade the areas of your EEG components. Simultaneously, `shade_components()` will print the code you need to add to your plot to insert your newly created component shading. Note that you need to replace `'YOURDF'` with the name of the object you saved the function's output to. Make sure you add `geom_rect()` before your other `geoms` so the shading lies below the data you're plotting. Don't forget to add `+` before and/or after the additional lines if needed. Also note that a specific order of `geoms` in your plot may be required, as well as certain requirements how to pass your data to `ggplot()`. See [examples](https://github.com/einGlasRotwein/ForBioPsy/tree/master/news%20and%20examples/Examples/shade_components.R) for clarification.

```R
# Plot before
ggplot() +
  geom_line(data = av_chicks, aes(x = Time, y = weight, colour = Diet)) +
  chick_theme
```
![](https://github.com/einGlasRotwein/ForBioPsy/blob/master/news%20and%20examples/Examples/pics/chickplot.png)

```R
# Throw some shade
library(ForBioPsy)
shading <- shade_components(components = c("phase 1", "phase 2", "phase 3"),
                            durations = c("5 - 10", "10.5 - 12", "16 - 19"))
```

```R
# Plot afterwards
ggplot() +
  geom_rect(data = shading,
            aes(xmin = xstart, xmax = xend, ymin = -Inf, ymax = Inf,
                fill = component), alpha = .5) +
  scale_fill_manual('component', values = c('#E3E3E3', '#C8C6C6', '#E3E3E3')) +
  geom_line(data = av_chicks, aes(x = Time, y = weight, colour = Diet)) +
  chick_theme
```
![](https://github.com/einGlasRotwein/ForBioPsy/blob/master/news%20and%20examples/Examples/pics/chickshades.png)

### generate_shifted_axis()
Generate a dataframe and geoms to add an auxiliary axis to a plot. The main output of the function is a dataframe that contains all the information needed to build an auxiliary axis with tick marks for your plot which cross the orthogonal axis at a specified intercept. Simultaneously, `generate_shifted_axis()` will print the code you need to add to your plot to insert your newly created auxiliary axis. Note that you need to replace `'YOURDF'` with the name of the object you saved the function's output to. Head to [examples](https://github.com/einGlasRotwein/ForBioPsy/tree/master/news%20and%20examples/Examples/shifted_axis.R) to see it in full action, but have a little taste here:

```R
# Plot before
ggplot() +
  geom_line(data = av_chicks, aes(x = Time, y = weight, colour = Diet)) +
  chick_theme
```

![](https://github.com/einGlasRotwein/ForBioPsy/blob/master/news%20and%20examples/Examples/pics/chickplot.png)

```R
# Generate an auxiliary x-axis
x_ticks <- generate_shifted_axis(
  limits = c(0, 20), steps = 5, other_ax_steps = 50,
  axis = "x", intercept = 150
)
```

```R
# Will print
# x-axis generated.
#
# Please add the following geoms to your plot and replace 'YOURDF' with the
# object you saved this function's output in:
#
# geom_hline(yintercept = 150) +
# geom_segment(data = 'YOURDF', aes(x = ticks, y = intercept - tick_sz * .5,
# xend = ticks, yend = intercept + tick_sz * .5))
```

```R
# Add it to the plot
ggplot() +
  geom_line(data = av_chicks, aes(x = Time, y = weight, colour = Diet)) +
  chick_theme +
  geom_hline(yintercept = 150) +
  geom_segment(data = x_ticks,
               aes(x = ticks, y = intercept - tick_sz * .5,
                   xend = ticks, yend = intercept + tick_sz * .5))
```
![](https://github.com/einGlasRotwein/ForBioPsy/blob/master/news%20and%20examples/Examples/pics/chickplot_aux_x.png)
