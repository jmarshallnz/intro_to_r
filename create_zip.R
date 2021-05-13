# create zip file for the course

exercise_files <- file.path("exercises", sprintf("ggplot%02i.R", 1:3))
extras <- "exercises/quakes.R"
data_files <- list.files("data/horizons_river_quality", recursive = TRUE, full.names = TRUE)
all_files <- c("intro_to_r.Rproj", exercise_files, data_files, extras)
zip('intro_to_visualisation.zip', all_files)

solution_files <- file.path("solutions", sprintf("ggplot%02i.R", 1:3))
zip('visualisation_solutions.zip', all_files)
