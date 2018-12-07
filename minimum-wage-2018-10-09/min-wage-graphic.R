library(tidyverse)
library(data.table)
library(maps)
library(extrafont)
suppressMessages(loadfonts())

df <- fread("min-wages.csv")
df$State <- tolower(df$State)
colnames(df) <- c("State", "minwage")

us_data <- map_data("state")

data <- merge(us_data, df, by.x = "region", by.y = "State")

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
      # panel.grid.minor = element_line(color = "#ebebe5", size = 0.2),
      #panel.grid.major = element_line(color = "#ebebe5", size = 0.2),
      panel.grid.minor = element_blank(),
      plot.background = element_rect(fill = "#f5f5f2", color = NA),
      panel.background = element_rect(fill = "#f5f5f2", color = NA),
      legend.background = element_rect(fill = "#f5f5f2", color = NA),
      panel.border = element_blank(),
      ...
    )
}

p <- ggplot(data, aes(x = long, y = lat)) +
  geom_polygon(aes(group = group, fill = minwage), color = "#444444", size = 0.15) +
  coord_map() + theme_map() +
  theme(legend.position = "bottom") +
  labs(title = "Minimum wage by state in 2018",
       subtitle = "Amazon's minimum wage exceeds the minimum wage in every state",
       caption = "Source: National Conference of State Legislatures\nMap by Brian Gentry | Online Visual Editor") +
  scale_fill_distiller(palette = "RdBu", direction = 1) +
  guides(fill = guide_colorbar(title = "Minimum wage",
                               direction = "horizontal",
                               barheight = unit(2, units = "mm"),
                               barwidth = unit(50, units = "mm"),
                               draw.ulim = F,
                               title.position = 'top',
                               # some shifting around
                               title.hjust = 0.5,
                               label.hjust = 0.5))

ggsave("minimum-wage.jpg", p, dpi = 300, width = 11)
print(p)
