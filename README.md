# InterGrainFunctions

### The `InterGrainFunctions` package contains a list of functions to improve the timeliness, reliability and repeatability of common tasks carried out within the breeding program. These include routine production of trial designs from NVT supplied excel files using `NVTconvert` or file format conversion using `FieldScorer`.

#### This package and suite of functions is very much in the development phase and can be downloaded directly into `R` using... 
```
install_github("CalumWatt/InterGrainFunctions")
```
#### `install_github` is a function of the `Devtools` package.

# Functions
### 1. NVTconvert was developed for the sole purpose of making `Allan Rattey's` life easier.

The National Variety Trial (NVT) system is a national approach to plant variety evaluation with a focus on providing credible information to growers about newly released crop varieties in environments relevant to them.

This package creates trial designs based on user defined crop species (i.e. Barley) and crop sub-types (i.e. Main Season). `NVTconvert` uses `ggplot2` to visualise each specific trial   in Range x Row layout and the function creates trial specific .jpeg files. Trial figures will be output into a newly created system file to avoid file directory congestion.

```
NVTconvert(data.frame, Crop.Species = "Wheat", Sub.Series = "Main Season", Location = "Trial.Location", State = "State", Code = "Trial.Code")
```
 
<img src="https://github.com/CalumWatt/NVTconvert/blob/1a88d84337d08c1363d7f23971d788a8ebce449d/figs/Ballidu%20-%20WA%20-%20WMaA21BALL6%20-%20Main%20Season%20.jpeg" width="500px">

### 2. Fieldscorer takes .xls trial designs in Agrobase format and spits out files in a suitable format for the Fieldscorer app. 

Within the function lies a loop which will create Fieldscorer files for each experiment in the .xls file. It is preferable to save Agrobase files by series i.e. "21WS0E" so that the `Trialtype =` argument can be used although this is not necessary and can be omitted from the call to Fieldscorer.

An example .xls file exists in the data directory for `InterGrainFunctions`. The file contains two 2021 trials from Corrigin and calling.....

```
library("InterGrainFunctions")

data(agrobasepractice) #Data is imported as data.frame, however Fieldscorer function will crash and instead requires as.tibble

Fieldscorer(agrobasepractice, Experiment = "expt", Trialtype = "21WS1", Genotype = "name", Barcode = "barcode", Pedigree = NULL)
```

will result in the creation of two files, one for each trial. Defaulting `Pedigree` as NULL is important because we may wish to create Fieldscorer files for third parties where we may wish to omit this level of information.
