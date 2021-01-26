library(tidyverse)
library(lubridate)
library(TSP)

ni <- read_csv("~/data/data/LAWA/RiverWQMonitoringData_NorthIsland_2004-18.csv",
               col_types = cols(RawValue = col_character(),
                             Symbol = col_character()))
si <- read_csv("~/data/data/LAWA/RiverWQMonitoringData_SouthIsland_2004-18.csv",
               col_types = cols(RawValue = col_character(),
                                Symbol = col_character()))

ni <- bind_rows(ni, si)
ni %>% group_by(LawaSiteID, Date) %>% summarise(total = n(), len = length(unique(Indicator)))

ni %>% filter(LawaSiteID == "ebop-00001", Date=="20-Jan-16")
ni %>% count(Indicator)

ni %>% group_by(Indicator) %>% summarise(u = length(unique(paste0(Date, LawaSiteID))))

wider <- ni %>% filter(Indicator != "Indicator") %>%
  select(Agency, Region, SiteID, SWQLanduse, SWQAltitude, Lat, Long, Date, Indicator, Value) %>%
  pivot_wider(names_from = Indicator, values_from = Value, values_fn = first) %>%
  mutate(Date = dmy(Date))

dim(wider)

wider %>% names()
# NH4 = ammonia and ammonium
# TURB = Turbidity
# BDISC = Black Disc
# DRP = Dissolved reactive phosphorus (in the water)
# ECOLI = E. coli
# TN = Total Nitrogen
# TP = Total Phosphorus
# PH = pH
# TON = Total Oxygenated Nitrogen nitrite nitrogen+ nitrate nitrogen

sites <- wider %>% select(Latitude = Lat, Longitude = Long, SiteID) %>% unique() %>%
  tibble::rowid_to_column("LocationID")

# Cluster the SiteID spatially by taking a travelling salesman tour through all sites
set.seed(4)
etsp <- ETSP(data.frame(x=sites$Longitude, y=sites$Latitude), labels = sites$LocationID)
tour <- solve_TSP(etsp)
plot(etsp, tour, xlim=c(173,175), ylim=c(-40,-38))
text(etsp, labels = sites$LocationID)
foo <- cut_tour(tour, 48, exclude_cut = FALSE)
plot(etsp)
lines(etsp[foo,])

plot(etsp)
plot(etsp[foo[1:106],], col='red')
lines(etsp[foo[1:106],])

# What we want is 100 stretches through 1056 observations. So we should start at
i <- 1:100
num_per_student <- 120
student_rows <- tibble(student = 1:100, start = round((length(foo)-num_per_student)/(100-1) * (student-1) + 1),
                       end = start + num_per_student - 1) %>%
  mutate(end = pmin(end, length(foo)))

grab_sites <- function(student, start, end) {
  rows = foo[start:end]
  sites[rows,]
}
foo <- student_rows %>% pmap_dfr(grab_sites, .id = "StudentID")

# Right, now dump this data out as spreadsheet
datasets <- foo %>% group_split(StudentID)

dump_data <- function(subset, out_path = ".") {
  out_data <- subset %>% select(SiteID) %>% left_join(wider, by="SiteID") %>%
    select(SiteID, everything()) %>%
    select(-Agency, -Region)
  student = subset %>% pull(StudentID) %>% first() %>% as.numeric()
  write_csv(out_data, file.path(out_path, sprintf("lawa%02i.csv", student %% 100)))
}

out_path <- here::here("data/horizons_river_quality/LAWA")
fs::dir_create(out_path)
out <- map(datasets, dump_data, out_path = out_path)


# OLD STUFF BELOW HERE

ggplot(wider %>% filter(Region == "waikato"), aes(x=SWQLanduse, y = as.numeric(ECOLI), col=SWQAltitude)) + 
  geom_boxplot() +
  scale_y_log10()

ggplot(wider %>% filter(Region == "waikato"), aes(x=SWQLanduse, y = as.numeric(PH), col=SWQAltitude)) + 
  geom_boxplot() +
  scale_y_log10()

# boxplot