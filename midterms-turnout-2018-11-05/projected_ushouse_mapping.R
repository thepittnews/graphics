library(rgdal)
library(tidyverse)
library(data.table)
library(RColorBrewer)

setwd("~/pitt-news-graphics/2018-2019/10/19/elections/")

new_districts <- readOGR(dsn = "new_districts", layer = "new_districts")
new_districts <- fortify(new_districts) 
new_districts$id <- as.numeric(new_districts$id)

swap <- data.frame(old = c(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17),
                   new = c(1, 2, 3, 4, 5, 6, 7, 10, 11, 12, 13, 14, 15, 16, 17, 18, 8, 9))
new_districts$id <- sapply(new_districts$id, function(i) {
  return(swap[swap$old == i, "new"])
})

new_districts$id <- factor(new_districts$id)

#new_districts$id <- as.numeric(new_districts$id) + 1

county <- fortify(readOGR(dsn = "PA_Counties_clip", layer = "PA_Counties_clip"))

setwd("~/pitt-news-graphics/2018-2019/11/05/elections")
df <- fread("data.csv")
color_map <- colorRamp(brewer.pal(n = 11, name = "RdBu"), interpolate = "spline")
df <- cbind(df, color_map(df$D/100))
colnames(df) <- c("district", "D", "Rep", "I",
                  "r", "g", "b")
df$color <- rgb(df$r/256, df$g/256, df$b/256)
cols <- df$color
names(cols) <- df$district

new_districts <- merge(new_districts, df, by.x = "id", by.y = "district")

theme_map <- function(...) { # taken from Timo Grossenbacher
  theme_minimal() +
    theme(
      text = element_text(family = "Helvetica", color = "#22211d"),
      axis.line = element_blank(),
      axis.text.x = element_blank(),
      axis.text.y = element_blank(),
      axis.ticks = element_blank(),
      axis.title.x = element_blank(),
      axis.title.y = element_blank(),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      plot.background = element_rect(fill = "#f5f5f2", color = NA), 
      panel.background = element_rect(fill = "#f5f5f2", color = NA), 
      legend.background = element_rect(fill = "#f5f5f2", color = NA),
      panel.border = element_blank(),
      ...
    )
}

to_watch <- c(1, 5, 8, 10, 17)

plots <- lapply(to_watch, function(i) {
  x <- subset(new_districts, id == i)
  y <- subset(new_districts, id != i)
  p <- ggplot() + 
    geom_polygon(data = y,
                 aes(x = long, y = lat, group = group), color = "black",size = 0.3,
                 alpha = 0.2, fill = "white") +
    geom_polygon(data = x,
                 aes(x = long, y = lat, group = group, fill = id), color = ifelse(x$D > 50, "#053061", "#67001F"),size = 1,
                 alpha = 1) +
    geom_path(data = county,
              aes(x = long, y = lat, group = group), size = 0.02) +
    scale_fill_manual(values = cols) +
    coord_map(xlim = range(new_districts$long), ylim = range(new_districts$lat)) +
    guides(fill = F) +
    theme_map()

  ggsave(paste0("district_", i, ".png"), p, height = 7, width = 11, dpi = 300)
})




#ggsave("new_districts.png", p, height = 11, dpi = 300)
