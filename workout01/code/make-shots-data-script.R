######################
##title: make-shot-data-script
##description:creating a csv data file shots-data.csv that will contain the required variables to be used in the visualization phase. 
##inputs:andre-iguodala.csv;draymond-green.csv;kevin-durant.csv;klay-thompson.csv;stephen-curry.csv
##outputs:andre-iguodala-summary.txt;draymond-green-summary.txt;kevin-durant-summary.txt;klay-thompson-summary.txt;stephen-curry-summary.txt;shots-data-summary.txt;shots-data.csv
######################

#Read in the five data sets
iguodala <- read.csv("../data/andre-iguodala.csv", stringsAsFactors = FALSE)
green <- read.csv("../data/draymond-green.csv", stringsAsFactors = FALSE)
durant <- read.csv("../data/kevin-durant.csv", stringsAsFactors = FALSE)
thompson <- read.csv("../data/klay-thompson.csv", stringsAsFactors = FALSE)
curry <- read.csv("../data/stephen-curry.csv", stringsAsFactors = FALSE)

#Add a column name to each imported data frame
library(dplyr)
iguodala <- mutate(iguodala,name='Andre Iguodala')
green <- mutate(green,name='Graymond Green')
durant <- mutate(durant,name='Kevin Durant')
thompson <-mutate(thompson,name='Klay Thompson')
curry <- mutate(curry,name='Stephen Curry')

#Change the original values of shot_made_flag
iguodala$shot_made_flag[iguodala$shot_made_flag=='n']='shot_no'
iguodala$shot_made_flag[iguodala$shot_made_flag=='y']='shot_yes'
green$shot_made_flag[green$shot_made_flag=='n']='shot_no'
green$shot_made_flag[green$shot_made_flag=='y']='shot_yes'
durant$shot_made_flag[durant$shot_made_flag=='n']='shot_no'
durant$shot_made_flag[durant$shot_made_flag=='y']='shot_yes'
thompson$shot_made_flag[thompson$shot_made_flag=='n']='shot_no'
thompson$shot_made_flag[thompson$shot_made_flag=='y']='shot_yes'
curry$shot_made_flag[curry$shot_made_flag=='n']='shot_no'
curry$shot_made_flag[curry$shot_made_flag=='y']='shot_yes'

#Add a column minute that contains the minute number where a shot occurred
iguodala$minute <- iguodala$period*12 - iguodala$minutes_remaining
green$minute <- green$period*12 - green$minutes_remaining
durant$minute <- durant$period*12 - durant$minutes_remaining
thompson$minute <- thompson$period*12 - thompson$minutes_remaining
curry$minute <- curry$period*12 - curry$minutes_remaining

#Use sink() to send the summary() output of each imported data frame into individuals text files
sink(file = '~/Desktop/STAT 133/workout01/output/andre-iguodala-summary.txt')
summary(iguodala)
sink()
sink(file = '~/Desktop/STAT 133/workout01/output/draymond-green-summary.txt')
summary(green)
sink()
sink(file = '~/Desktop/STAT 133/workout01/output/kevin-durant-summary.txt')
summary(durant)
sink()
sink(file = '~/Desktop/STAT 133/workout01/output/klay-thompson-summary.txt')
summary(thompson)
sink()
sink(file = '~/DesktopSTAT 133/workout01/output/stephen-curry-summary.txt')
summary(curry)
sink()

#stack the tables into one single data frame
single_df <- rbind(iguodala,green,durant,thompson,curry)
write.csv(x=single_df,file='~/Desktop/STAT 133/workout01/data/shots-data.csv')

#Use sink() to send the summary() output of the assembled table.
sink(file = '~/Desktop/STAT 133/workout01/output/shots-data-summary.txt')
summary(single_df)
sink()