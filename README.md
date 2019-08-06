# MSPS
MSPS (McKern and Stewart Pubic Symphysis) is an R package that provides three-dimensional models of the original McKern and Stewart (1957) casts, data, and descriptions to aid with age estimation when physical casts are not available.

>Data sourced from McKern, T.W. and T.D. Stewart (1957) Skeletal Age Changes in Young American Males. Quartermaster Research and Develoment Command Technical Report EP-45, Natick, MA.

# Installation
```javascript
if(!require("devtools")) install.packages("devtools")
library(devtools)
install_github("jcaple18/MSPS")
library(MSPS)
MSPS()
```

# R Dependencies
The following R packages will be installed automatically:
- rgl
- rmarkdown
- shiny
- shinyjs
- shinyRGL
- shinythemes
- shinyWidgets
