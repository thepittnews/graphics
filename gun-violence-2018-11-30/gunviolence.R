library(rvest)
library(lubridate)

url <- "https://www.gunviolencearchive.org/reports/mass-shooting?page="
df <- data.frame()
for (i in 0:12) {
  temp_url <- paste0("https://www.gunviolencearchive.org/reports/mass-shooting?page=", i)
  s <- html_session(temp_url)
  table <- s %>% html_nodes("#block-system-main > section > div > table")
  table <- table[[1]] %>% html_table()
  df <- rbind(df, table)
}

df$`Incident Date` <- mdy(df$`Incident Date`)

write.csv(df, "gunviolence.csv", row.names = F)

library(data.table)
library(ggmap)
library(tidyverse)
library(googleway)

df <- fread("old-gunviolence.csv")

df$addy <- paste(df$Address, df$`City Or County`, df$State)

api <- "AIzaSyDd_3UfD0qKZYJg81cVCNL39dHf1hIo8mY"

locs <- sapply(1:nrow(df), function(i) {
  return(google_geocode(paste(df$addy[i], df$`City Or County`[i], df$State[i]), key = api))
})

ll <- data.frame(lat = numeric(), lng = numeric())

for (i in 1:(length(locs)/2)) {
  loc <- locs[[2*i - 1]]

  if (length(loc) > 1) {
    l <- loc$geometry$location
    print(nrow(l))
    ll[i, ] <- l[1, ]
  }
}

data <- cbind(df, ll)
write.csv(data, "addresses-gunviolence.csv", row.names = F)

