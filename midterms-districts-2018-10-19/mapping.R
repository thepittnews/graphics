library(rgdal)
library(tidyverse)

setwd("~/pitt-news-graphics/2018-2019/10/19/elections/")

old_districts <- readOGR(dsn = "cb_2017_us_cd115_500k", layer = "cb_2017_us_cd115_500k")
old_districts <- fortify(old_districts)

new_districts <- readOGR(dsn = "new_districts", layer = "new_districts")
centroids_old <- data.frame(id = c(18, 12, 14, 3, 9),
                            long = c(-80.29098, -80.00, -79.90245, -79.95, -79.93),
                            lat = c(40.3, 40.57956, 40.42, 40.7, 40.18))
new_districts <- fortify(new_districts)

theme_tpn_map <- function(...) {
  theme_minimal() +
    theme(
      text = element_text(family = "Helvetica Light", color = "#444444"),
      axis.title = element_text(family = "Helvetica Light", color = "#222222"),
      plot.title = element_text(family = "Garamond", color = "#000000", size = 20),
      plot.background = element_rect(fill = "#f9fbff"),
      legend.position = "bottom",
      legend.title.align = 0.5,
      panel.grid.minor = element_blank(),
      panel.grid.major = element_blank(),
      axis.line = element_blank(),
      axis.text.x = element_blank(),
      axis.text.y = element_blank(),
      axis.ticks = element_blank(),
      axis.title.x = element_blank(),
      axis.title.y = element_blank()
    )
}

county <- fortify(readOGR(dsn = "PA_Counties_clip", layer = "PA_Counties_clip"))

p <- ggplot() + 
  geom_polygon(data = old_districts,
               aes(x = long, y = lat, group = group,
                   fill = group, color = group),
               alpha = 0.2) +
  geom_path(data = county,
            aes(x = long, y = lat, group = group)) +
  geom_text(data = centroids_old,
            aes(x = long, y = lat, label = id)) +
  coord_map(xlim = c(-80.439302, -79.586266), ylim = c(40.162992, 40.723243)) +
  guides(fill = F, color = F) +
  theme_tpn_map()

ggsave("old_districts.png", p, height = 11, dpi = 300)
#ggsave("new_districts.png", p, height = 11, dpi = 300)
