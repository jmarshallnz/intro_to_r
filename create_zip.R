# create zip file for the course

exercise_files <- list.files("exercises", pattern = "*.R", full.names = TRUE)
data_files <- list.files("data", recursive = TRUE, full.names = TRUE)
all_files <- c("intro_to_r.Rproj", exercise_files, data_files)
zip('intro_to_r.zip', all_files)
