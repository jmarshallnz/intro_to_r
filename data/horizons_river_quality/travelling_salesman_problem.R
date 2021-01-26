library(TSP)

etsp <- ETSP(data.frame(x = runif(20), y = runif(20)))
tour <- solve_TSP(etsp)

tourtour_length(tour)

plot(etsp, tour)
tour

foo <- cut_tour(tour, cut = 1, exclude_cut = FALSE)

plot(etsp)
lines(etsp[foo,])

