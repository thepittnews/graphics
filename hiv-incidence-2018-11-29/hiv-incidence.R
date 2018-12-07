library(data.table)
library(tidyverse)
library(scales)
library(extrafont)
suppressMessages(loadfonts())

df <- fread("hiv-incidence.csv")

events <- data.frame(year = c(2000, 1985),
                     event = c("The CDC implements its\nnew policy on HIV.",
                               "Allies for Health + Wellbeing\nis founded at the height\nof the AIDS crisis."))

events$y <- sapply(events$year, function(year) {
  return(df$infections[df$year == year])
})

theme_tpn <- function(...) {
  theme_minimal() +
    theme(
      text = element_text(family = "Helvetica Light", color = "#444444"),
      axis.title = element_text(family = "Helvetica Light", color = "#222222"),
      plot.title = element_text(family = "Apple Garamond", color = "#000000", size = 20),
      plot.background = element_rect(fill = "#f9fbff"),
      legend.position = "bottom",
      legend.title.align = 0.5,
      panel.grid.minor = element_blank()
    )
}

p <- ggplot(df) + geom_bar(aes(x = year, y = infections*1000, fill = infections), stat="identity") +
  xlab("Year") + ylab("Annual infections") +
  scale_y_continuous(labels = comma, limits = c(0, max(df$infections) * 1200)) +
  scale_fill_distiller(palette = "Blues", direction = 1) +
  ggtitle("New HIV infections in the U.S. from 1981 to 2015") +
  labs(subtitle = "The number of new infections has declined since the AIDS crisis of the 1980s.",
       caption = "Source: CDC\nGraphic by Brian Gentry | Online Visual Editor") +
  guides(fill = guide_colorbar(title = "Infections",
                               ticks = F, title.position = "top")) +
  #geom_label(data = events,
  #          aes(x = year, y = (events$y + 10) * 1000, label = event),
  #          size = 3, family = "Helvetica Light", fill = "#ffffff") +
  theme_tpn()

ggsave("N_AIDS_20181129_BG.png", p, width = 11, height = 8.5, dpi = 300)
