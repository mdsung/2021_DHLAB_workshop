library(tidyverse)
library(furrr)
library(future.apply)
library(tictoc)

no_cores <- availableCores() - 1
plan(multicore, workers = no_cores)

slow_square = 
  function(x = 1) {
    x_sq = x^2 
    d = data.frame(value = x, value_squared = x_sq)
    Sys.sleep(2)
    return(d)
    }

tic()
serial_ex = lapply(1:12, slow_square)
toc(log = TRUE)

tic()
serial_ex = 1:12 %>% purrr::map(slow_square)
toc()

tic()
serial_ex = future.apply::future_lapply(1:12, slow_square)
toc(log = TRUE)

tic()
serial_ex = 1:12 %>% furrr::future_map(slow_square)
toc(log = TRUE)

