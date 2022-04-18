library(future)
plan(cluster, manual = TRUE)

library(future.apply)
cat(future_sapply(seq_len(nbrOfWorkers()), function(i) Sys.info()[["nodename"]]))