library(rgdal)
library(tidyverse)

setwd("~/pitt-news-graphics/2018-2019/12/04/elections/")

old_districts <- readOGR(dsn = "U.S._Congressional_Districts_for_Pennsylvania", 
                         layer = "U.S._Congressional_Districts_for_Pennsylvania")
old_districts <- fortify(old_districts)

new_districts <- readOGR(dsn = "new_districts", layer = "new_districts")
new_districts <- fortify(new_districts)

centroids_old <- old_districts %>% group_by(id) %>% summarise(lat = mean(lat), long = mean(long))
centroids_new <- new_districts %>% group_by(id) %>% summarise(lat = mean(lat), long = mean(long))

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
               alpha = 0.4) +
  geom_path(data = county,
            aes(x = long, y = lat, group = group), alpha = 0.1) +
  #geom_text(data = centroids_old,
  #          aes(x = long, y = lat, label = id)) +
  coord_map(xlim = c(-81.062643, -74.567961), ylim = c(39.209186, 42.707653)) +
  guides(fill = F, color = F) +
  theme_tpn_map()

ggsave("old_districts.png", p, dpi = 300)

p <- ggplot() + 
  geom_polygon(data = new_districts,
               aes(x = long, y = lat, group = group,
                   fill = group, color = group),
               alpha = 0.4) +
  geom_path(data = county,
            aes(x = long, y = lat, group = group), alpha = 0.1) +
  #geom_text(data = centroids_new,
  #          aes(x = long, y = lat, label = id)) +
  coord_map(xlim = c(-81.062643, -74.567961), ylim = c(39.209186, 42.707653)) +
  guides(fill = F, color = F) +
  theme_tpn_map()

ggsave("new_districts.png", p, dpi = 300)