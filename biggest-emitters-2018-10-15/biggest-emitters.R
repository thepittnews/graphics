library(tidyverse)
library(data.table)
library(maps)
library(extrafont)
suppressMessages(loadfonts())

df <- fread("biggest-emitters.csv")
df$company <- factor(df$company, levels =
                       df$company[order(-df$mtco2)])

df$mtco2 <- df$mtco2 / 1000

theme_map <- function(...) { # taken from Timo Grossenbacher
  theme_minimal() +
    theme(
      text = element_text(family = "Helvetica", color = "#22211d"),
      axis.line = element_blank(),
      axis.text.x = element_text(angle = 45, hjust = 1),
     # axis.text.y = element_blank(),
      axis.ticks = element_blank(),
      axis.title.x = element_blank(),
      #axis.title.y = element_blank(),
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


p <- ggplot(df, aes(x = company, y = mtco2)) +
  geom_bar(stat = "identity", aes(fill = mtco2), color = "#777777") +
  theme_map() +
  theme(legend.position = "bottom") +
  labs(title = bquote("Greenhouse gas emissions by company from 1988 to 2015"),
       subtitle = "These nine corporations constitute 34.4 percent of all industrial greenhouse gas emissions during this time period.",
       caption = "Source: CDP Carbon Majors Report 2017\nGraphic by Brian Gentry | Online Visual Editor") +
  scale_fill_distiller(palette = "Greens", direction = 1) +
  ylab(bquote("Greenhouse gas emissions (gigatonnes"~CO[2]~"equivalent)")) +
  guides(fill = guide_colorbar(title = "Greenhouse gas emissions",
                               direction = "horizontal",
                               barheight = unit(2, units = "mm"),
                               barwidth = unit(50, units = "mm"),
                               draw.ulim = F,
                               title.position = 'top',
                               # some shifting around
                               title.hjust = 0.5,
                               label.hjust = 0.5))

ggsave("ghg-emissions.png", p, dpi = 300, width = 9, height = 9)
print(p)
