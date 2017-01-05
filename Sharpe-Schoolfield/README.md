### Sharpe-Schoolfield Shiny App

This is a Shiny app to help visualise what the modified Sharpe-Schoolfield models represent.

The app plots the high inactivation only model and the full model and allows for the user to change the parameters to see what they do and how they change each curve.

The Shiny app is availble [here](https://padpadpadpad.shinyapps.io/Sharpe-Schoolfield/).


Alternatively it is super easy to run the app through your Rstudio/R:

```R
library(shiny)

# Easiest way is to use runGitHub
runGitHub("Shiny", "padpadpadpad", subdir = "Sharpe-Schoolfield/")

```

Or if you want you can clone the repository and run the app using "runApp()"

```R
# Firstly in command line, pull the repository into a desired destination using git
# Our example uses ~/Shiny_example

cd Shiny_example
git pull https://github.com/padpadpadpad/Shiny.git

# this should download the files necessary to run the app locally in R
# now in R!

library(shiny)
setwd("~/Shiny_example")
runApp()
```

Once in click one of the boxes at the top for one of the curves and away you go!
