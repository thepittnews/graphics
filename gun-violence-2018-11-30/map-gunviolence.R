library(data.table)
library(ggmap)
library(tidyverse)
library(googleway)

df <- fread("addresses-gunviolence.csv")

# us data
us <- map_data("state")

theme_tpn_map <- function(...) {
  theme_minimal() +
    theme(
      text = element_text(family = "Helvetica Light", color = "#444444"),
      axis.title = element_text(family = "Helvetica Light", color = "#222222"),
      plot.title = element_text(family = "Apple Garamond", color = "#000000", size = 20),
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

p <- ggplot(df) +
  geom_map(data = us, map = us,
           aes(map_id = region), colour = "#222222", fill = "#f9ffff") +
  geom_jitter(width = 0.25, height = 0.25,
              aes(x = lng, y = lat, size = `# Killed`, color = `# Killed`)) +
  scale_colour_distiller(palette = "Reds", direction = 1) +
  coord_map(xlim = range(us$long), ylim = range(us$lat)) + theme_tpn_map() + ggtitle("Deaths by mass shootings in the U.S. in 2018") +
  xlab("") + ylab("") + guides(size = guide_legend(),
                               colour = guide_legend()) +
  labs(subtitle = "A total of 362 people have died from mass shootings since the start of 2018.",
       caption = "Source: Gun Violence Archive\nA mass shooting is defined as an incident where four\nor more people are shot, not including the shooter.\n\nMap by Brian Gentry | Online Visual Editor")

ggsave("N_PsychMassShootingDeaths_BG.png", p, width = 11, height = 7.77, dpi = 300)

p <- ggplot(df) +
  geom_map(data = us, map = us,
           aes(map_id = region), colour = "#222222", fill = "#f9ffff") +
  geom_jitter(width = 0.25, height = 0.25,
              aes(x = lng, y = lat, size = `# Injured`, color = `# Injured`)) +
  scale_colour_distiller(palette = "Reds", direction = 1) +
  coord_map(xlim = range(us$long), ylim = range(us$lat)) + theme_tpn_map() + ggtitle("Injuries from mass shootings in the U.S. in 2018") +
  xlab("") + ylab("") + guides(size = guide_legend(),
                               colour = guide_legend()) +
  labs(subtitle = "A total of 1280 people have been injured in mass shootings since the start of 2018.",
       caption = "Source: Gun Violence Archive\nA mass shooting is defined as an incident where four\nor more people are shot, not including the shooter.\n\nMap by Brian Gentry | Online Visual Editor")

ggsave("N_PsychMassShootingInjuries_BG.png", p, width = 11, height = 7.77, dpi = 300)
