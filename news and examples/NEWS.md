# NEWS

## 26.07.2019
- Added function `delete_empty_BA_files()` which deletes empty or pseudo-empty .txt, .dat or .csv files
  - Will go through a given folder and delete files that are empty/blank or contain nothing but a header. See [example folder](https://github.com/einGlasRotwein/ForBioPsy/tree/master/inst/Examples), where dummy files are provided as well.
- Adapted internal `validate_input()` function, which can now deal with pre-specified input sets for a given argument where more than one value is allowed to be picked from.

## 25.07.2019
- Added function `shade_components()` which generates a dataframe and lines to add to a `ggplot()` to shade the plot area behind EEG components.
  - Actually `geom_rect()` and `scale_fill_manual()` in disguise.
  - See [example](https://github.com/einGlasRotwein/ForBioPsy/tree/master/inst/Examples/shaded_component.R).

## 24.07.2019
- Initialised repo and documentation of package.
- Added function `generate_shifted_axis()` which generates a dataframe and lines to add to a `ggplot()` for creating an auxiliary axis with ticks to a plot.
  - Actually `geom_segment()` and `geom_vline()` (or `geom_hline()`) in disguise.
  - See [example](https://github.com/einGlasRotwein/ForBioPsy/tree/master/inst/Examples/shifted_axis.R).
