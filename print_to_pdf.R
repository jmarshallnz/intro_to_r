library(tidyverse)
library(xaringan)
library(rvest)

to_pdf <- 1:3

files = data.frame(html = file.path('lectures', sprintf('lecture%02i.html', to_pdf)),
                   pdf = file.path('lectures', sprintf('lecture%02i.pdf', to_pdf)))

do_pdf <- function(html, pdf) {
  temp_html <- tempfile(tmpdir="lectures", fileext=".html")
  # parse the HTML and remove any shiny iframes
  parsed <- read_lines(html)
  out <- str_replace_all(parsed, '\\"https://shiny.massey.ac.nz.*?\\"', '\\""')
  write_lines(out, temp_html)
  decktape(temp_html, pdf)
  fs::file_delete(temp_html)
}

files %>% pmap(do_pdf)
