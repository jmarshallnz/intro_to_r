library(tidyverse)
library(xaringan)
library(rvest)

files = data.frame(html = list.files("slides", "*.html", full.names = TRUE)) %>%
  mutate(pdf = str_replace(html, ".html$", ".pdf"))

do_pdf <- function(html, pdf) {
  temp_html <- tempfile(tmpdir="slides", fileext=".html")
  # parse the HTML and remove any shiny iframes
  parsed <- read_lines(html)
  out <- str_replace_all(parsed, '\\"https://shiny.massey.ac.nz.*?\\"', '\\""')
  write_lines(out, temp_html)
  decktape(temp_html, pdf)
  fs::file_delete(temp_html)
}

files %>% pmap(do_pdf)
