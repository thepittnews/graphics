library(tidyverse)
library(data.table)
library(lubridate)
library(stringr)
library(extrafont)

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
      #panel.grid.minor = element_line(color = "#ebebe5", size = 0.2),
      #panel.grid.major = element_line(color = "#ebebe5", size = 0.2),
      panel.grid.minor = element_blank(),
      plot.background = element_rect(fill = "#f5f5f2", color = NA),
      panel.background = element_rect(fill = "#f5f5f2", color = NA),
      legend.background = element_rect(fill = "#f5f5f2", color = NA),
      panel.border = element_blank(),
      ...
    )
}

today <- "2019-01-11"
df <- fread(paste("data-", today, ".csv", sep=""))
matches <- split.data.frame(df, df$game)

for (idx in 1:length(matches)) {
  match <- matches[[idx]]
  match$game <- -1

  if (match$score[1] < match$score[2]) {
    match$score[1] <- -match$score[1]
  } else {
    match$score[2] <- -match$score[2]
  }

  fill_cols <- match$fill
  names(fill_cols) <- match$team

  text_cols <- match$text
  names(text_cols) <- match$team

  p <- ggplot(match) + geom_bar(aes(x = game, y = score, fill = team), stat = "identity") +
    coord_flip() + theme_map() +
    guides(fill = F, colour = F) +
    geom_text(aes(x = game, y = score/2, color = team, label = abs(score)),
              family = "Roboto", size = 5) +
    geom_text(aes(x = game+0.3, y = score/2, color = team, label = team),
              family = "Roboto", size = 7) +
    scale_fill_manual(values = fill_cols) +
    scale_colour_manual(values = text_cols) +
    labs(title = paste("Projected point total for", match$team[1], "vs.", match$team[2], sep=" "),
         subtitle = "Graphic by Jon Moss | Online Visual Editor",
         caption = "Source: OddsShark")

  ggsave(paste("odds_", today, "-", idx, ".png", sep = ""), p,
         width = 11, height = 4, dpi = 300)
}
