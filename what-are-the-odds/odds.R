library(tidyverse)
library(data.table)
library(lubridate)
library(stringr)
library(extrafont)

today <- "2018-12-07"
df <- fread(paste("data-", today, ".csv", sep=""))

df$score <- df$score * df$win

theme_map <- function(...) { # taken from Timo Grossenbacher
  theme_minimal() +
    theme(
      text = element_text(family = "Roboto", color = "#22211d"),
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

fill_cols <- df$fill
names(fill_cols) <- df$team

text_cols <- df$text
names(text_cols) <- df$team
df$game <- -df$game

p <- ggplot(df) + geom_bar(aes(x = game, y = score, fill = team), stat = "identity") +
  coord_flip() + theme_map() +
  guides(fill = F, colour = F) +
  geom_text(aes(x = game, y = score/2, color = team, label = abs(score)),
            family = "Roboto", size = 5) +
  geom_text(aes(x = game+0.3, y = score/2, color = team, label = team),
            family = "Roboto", size = 7) +
  scale_fill_manual(values = fill_cols) +
  scale_colour_manual(values = text_cols) +
  labs(title = "Projected point totals for sports games",
       subtitle = "Graphic by Jon Moss | Staff Writer",
       caption = "Source: Scores & Stats")

ggsave(paste("odds_", today, ".png", sep = ""), p,
       width = 11, height = 4, dpi = 300)
