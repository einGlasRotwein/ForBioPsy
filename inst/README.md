# Documentation
Find current issues and a to do in this README. See current changes in the [NEWS
file](https://github.com/einGlasRotwein/ForBioPsy/tree/master/inst/NEWS.md).

## TO DO
- [ ] Dummy
- [ ] bullet
- [ ] points

## Plotting Functions
### generate_shifted_axis()
Generate a dataframe and geoms to add an auxiliary axis to a plot. The main output of the function is a dataframe that contains all the information needed to build an auxiliary axis with tick marks for your plot which cross the orthogonal axis at a specified intercept. Simultaneously, `generate_shifted_axis()` will print the code you need to add to your plot to insert your newly created auxiliary axis. Note that you need to replace `'YOURDF'` with the name of the object you saved the function's output to. Head to [examples](https://github.com/einGlasRotwein/ForBioPsy/tree/master/inst/Examples/shifted_axis.R) to see it in full action, but have a little taste here:

```R
# Plot before
av_chicks %>%
  ggplot(aes(x = Time, y = weight)) +
  geom_line(aes(colour = Diet)) +
  chick_theme
```

![](https://github.com/einGlasRotwein/ForBioPsy/tree/master/inst/Examples/pics/chickplot.png)

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
av_chicks %>%
  ggplot(aes(x = Time, y = weight)) +
  geom_line(aes(colour = Diet)) +
  chick_theme +
  geom_hline(yintercept = 150) +
  geom_segment(data = x_ticks,
               aes(x = ticks, y = intercept - tick_sz * .5,
                   xend = ticks, yend = intercept + tick_sz * .5))
```
![](https://github.com/einGlasRotwein/ForBioPsy/tree/master/inst/Examples/pics/chickplot_aux_x.png)
