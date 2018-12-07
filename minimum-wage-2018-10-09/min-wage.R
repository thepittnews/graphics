library(rvest)

url <- "http://www.ncsl.org/research/labor-and-employment/state-minimum-wage-chart.aspx"
s <- html_session(url)

table <- s %>% html_nodes(xpath = "/html/body/form/div[4]/div[6]/div/div/div[1]/div[1]/div/div/div[2]/div/div/div/table[1]") %>% html_table()
table <- table[[1]][, c("State", "Minimum Wage")]
write.csv(table, "min-wages.csv", row.names = F)