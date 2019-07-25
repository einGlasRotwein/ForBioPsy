# NEWS

## 24.07.2019
- Added function `shade_components()` which generates a dataframe and lines to add to a `ggplot()` to shade the plot area behind EEG components.
  - Actually `geom_rect()` and `scale_fill_manual()` in disguise.
  - See [example](https://github.com/einGlasRotwein/ForBioPsy/tree/master/inst/Examples/shaded_component.R).

## 24.07.2019
- Initialised repo and documentation of package.
- Added function `generate_shifted_axis()` which generates a dataframe and lines to add to a `ggplot()` for creating an auxiliary axis with ticks to a plot.
  - Actually `geom_segment()` and `geom_vline()` (or `geom_hline()`) in disguise.
  - See [example](https://github.com/einGlasRotwein/ForBioPsy/tree/master/inst/Examples/shifted_axis.R).
