# amelia

library(mice)
library(Amelia)
library(tidyverse)
library(VIM)

data(nhanes)


md.pattern(nhanes)

mice_plot <- aggr(nhanes, col=c('navyblue','yellow'),
                  numbers=TRUE, sortVars=TRUE,
                  labels=names(nhanes), cex.axis=.7,
                  gap=3, ylab=c("Missing data","Pattern"))


mi <- nhanes %>% 
  as.data.frame() %>% 
  amelia(
    m = 5,
    max.resample = 1000,
    ord = c("age"),
    parallel = "multicore"
  )

mi


mi$imputations$imp1 %>% head(2)
