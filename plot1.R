library(tidyverse)

setwd("~/Documents/datascience/eda/CourseProject2")
pngFile <- "plot1.png"

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# sum the emissions from NEI, by year
agg <-  aggregate(Emissions ~ year, NEI, sum)

# show emissions in mega-tons
agg$Emissions <- agg$Emissions / 10^6

# open png device
png(filename = pngFile, width = 480, height = 480)

# plot
barplot(height = agg$Emissions, horiz = FALSE, names.arg=agg$year, width = 1, main = "Emissions by Year",
        xlab = "Year", ylab = "Emissions (Megatons)")

# save png file
dev.off()

