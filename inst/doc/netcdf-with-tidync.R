## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
options(pillar.subtle = FALSE, pillar.sigfig = 4)

## ------------------------------------------------------------------------
ice_file <- system.file("extdata", "ifremer", "20171002.nc", package = "tidync", mustWork = TRUE)
library(RNetCDF)
print.nc(open.nc(ice_file))

## ------------------------------------------------------------------------
library(tidync)
tidync(ice_file)

## ----activate------------------------------------------------------------
tidync(ice_file) %>% activate("D2")

## ----NSE-activate--------------------------------------------------------
tidync(ice_file) %>% activate(time)

## choose grid by variable name, which happens to be the default grid here
tidync(ice_file) %>% activate(quality_flag)

## same as the default
tidync(ice_file) %>% activate("D0,D1,D2")

## ------------------------------------------------------------------------
concentration <- tidync(ice_file) 
concentration %>% hyper_filter() 

## ------------------------------------------------------------------------
concentration %>% hyper_filter(nj = nj < 20)

## ------------------------------------------------------------------------
concentration %>% 
  hyper_filter(ni = index < 20, 
               nj = dplyr::between(index, 30, 100))

## ------------------------------------------------------------------------
hf <- concentration %>% 
  hyper_filter(ni = index < 20, 
               nj = dplyr::between(index, 30, 100))

## as an array
arr <- hf %>% hyper_array()
str(arr)

## as a data frame
hf %>% 
  hyper_tibble() %>% 
  dplyr::filter(!is.na(concentration))

## ----sea-ice-example-----------------------------------------------------
hf

## ----eval= FALSE---------------------------------------------------------
#  ## WARNING, pseudocode
#  var_get(con, variable, start = c(1, 1, 1), count = c(10, 5, 1))

## ----dimension-index,eval=TRUE-------------------------------------------
hf %>% hyper_filter(nj = index < 20, ni = ni > 20)

hf %>% hyper_filter(nj = index < 20)

## ------------------------------------------------------------------------
hyper_vars(hf)
hyper_dims(hf)

## change the active grid
hf %>% activate("D2") %>% 
  hyper_vars()

active(hf)

hf %>% activate("D2") %>%
  active()

## ------------------------------------------------------------------------
hyper_transforms(hf)

