resultsX <- resultsFrame[,-c(1)] %>% group_by(Blocks) %>% summarise_all(funs(mean))
