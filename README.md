# InterGrainFunctions

### The `InterGrainFunctions` package contains a list of functions to improve the timeliness, reliability and repeatability of common tasks carried out within the breeding program. These include routine production of trial designs from NVT supplied excel files using `NVTconvert` or file format conversion using `FieldScorer`.

#### This package and suite of functions is very much in the development phase

# Functions
### 1. NVTconvert was developed for the sole purpose of making `Allan Rattey's` life easier.

The National Variety Trial (NVT) system is a national approach to plant variety evaluation with a focus on providing credible information to growers about newly released crop varieties in environments relevant to them.

This package creates trial designs based on user defined crop species (i.e. Barley) and crop sub-types (i.e. Main Season). `NVTconvert` uses `ggplot2` to visualise each specific trial   in Range x Row layout and the function creates trial specific .jpeg files. Trial figures will be output into a newly created system file to avoid file directory congestion.
 
<img src="https://github.com/CalumWatt/NVTconvert/blob/1a88d84337d08c1363d7f23971d788a8ebce449d/figs/Ballidu%20-%20WA%20-%20WMaA21BALL6%20-%20Main%20Season%20.jpeg" width="500px">
