######################
##title:make-shot-chats-script
##description:the creation of shot charts
##inputs:
##outputs:
######################

library(jpeg)
library(png)
library(grid)
library(ggplot2)

#scatterplot
#klay_scatterplot <- ggplot(data = thompson) +
  #geom_point(aes(x = x, y = y, color = shot_made_flag))

#court image
court_file <- "../images/nba-court.jpg"

#create raste object
court_image <- rasterGrob(
  readJPEG(court_file), 
  width = unit(1, "npc"), 
  height = unit(1, "npc"))

# shot chart with court background
iguodala_shot_chart <- ggplot(data = iguodala) +
  annotation_custom(court_image, -250, 250, -50, 420) + 
  geom_point(aes(x = x, y = y, color = shot_made_flag)) + 
  ylim(-50, 420) +
  ggtitle('Shot Chart: Andre Iguodala (2016 season)') + 
  theme_minimal()
green_shot_chart <- ggplot(data = green) +
  annotation_custom(court_image, -250, 250, -50, 420) + 
  geom_point(aes(x = x, y = y, color = shot_made_flag)) + 
  ylim(-50, 420) +
  ggtitle('Shot Chart: Draymond Green (2016 season)') + 
  theme_minimal()
durant_shot_chart <- ggplot(data = durant) +
  annotation_custom(court_image, -250, 250, -50, 420) + 
  geom_point(aes(x = x, y = y, color = shot_made_flag)) + 
  ylim(-50, 420) +
  ggtitle('Shot Chart: Kevin Durant (2016 season)') + 
  theme_minimal()
thompson_shot_chart <- ggplot(data = thompson) +
  annotation_custom(court_image, -250, 250, -50, 420) + 
  geom_point(aes(x = x, y = y, color = shot_made_flag)) + 
  ylim(-50, 420) +
  ggtitle('Shot Chart: Klay Thompson (2016 season)') + 
  theme_minimal()
curry_shot_chart <- ggplot(data = curry) +
  annotation_custom(court_image, -250, 250, -50, 420) + 
  geom_point(aes(x = x, y = y, color = shot_made_flag)) + 
  ylim(-50, 420) +
  ggtitle('Shot Chart: Stephen Curry (2016 season)') + 
  theme_minimal()

#create shot charts (with court backgrounds) for each player, and save the plots in PDF format
pdf(file = "../images/andre-iguodala-shot-chart.pdf",
    width = 6.5, height = 5)
iguodala_shot_chart
dev.off()
pdf(file = "../images/draymond-green-shot-chart.pdf",
    width = 6.5, height = 5)
green_shot_chart
dev.off()
pdf(file = "../images/kevin-durant-shot-chart.pdf",
             width = 6.5, height = 5)
durant_shot_chart
dev.off()
pdf(file = "../images/klay-thompson-shot-chart.pdf",
             width = 6.5, height = 5)
thompson_shot_chart
dev.off()
pdf(file = "../images/stephen-curry-shot-chart.pdf",
    width = 6.5, height = 5)
curry_shot_chart
dev.off()

#Create one graph, using facetting, to show all the shot charts in one image
shot_chart <- ggplot(data = single_df) +
  annotation_custom(court_image, -250, 250, -50, 420) + 
  geom_point(aes(x = x, y = y, color = shot_made_flag)) + 
  ylim(-50, 420) +
  ggtitle('Shot Chart: GSW (2016 season)') + 
  theme_minimal()+
  facet_wrap(~name)

#Save this image in PDF format
pdf(file = "../images/gsw-shot-charts.pdf",
    width = 8, height = 7)
shot_chart
dev.off()

#Save this image in PNG format
ggsave("../images/gsw-shot-charts.png",width=8,height=7)