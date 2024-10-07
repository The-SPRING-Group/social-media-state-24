page <- read_html("https://www.ncsl.org/technology-and-communication/social-media-and-children-2023-legislation")

jurisdictions <- page |> 
  html_elements("td:nth-child(1)") |> 
  html_text()

bill_numbers <- page |> 
  html_elements("td:nth-child(2)") |> 
  html_text()

titles <- page |> 
  html_elements("td:nth-child(3)") |> 
  html_text()

statuss <- page |> 
  html_elements("td:nth-child(4)") |> 
  html_text()

summarys <- page |> 
  html_elements("td:nth-child(5)") |> 
  html_text()

data_raw <- tibble(
  jurisdiction = jurisdictions,
  number = bill_numbers,
  title = titles,
  status = statuss,
  summary = summarys
)

'%!in%' <- function(x,y)!('%in%'(x,y))


state_data <- data_raw |> 
  mutate(
    jurisdiction = as_factor(jurisdiction),
    status = as_factor(status)
  ) |> 
  filter(
    jurisdiction %!in% c("Guam", "N. Mariana Islands", "Puerto Rico", "A. Samoa", "U.S. Virgin Islands", "District of Columbia")
  ) |> 
  write_csv("data/state-sm-23")