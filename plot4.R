library(tidyverse)
library(data.table)

setwd("~/Documents/datascience/eda/CourseProject2")
pngFile <- "plot4.png"

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# coal data
merged <- merge(NEI, SCC, by = "SCC")
merged <- data.table(merged)
coal <- merged[Short.Name %like% "Coal"]

# display data in tons
coal$Emissions <- coal$Emissions / 10^3

# sum the emissions from coal, by year
agg <-  aggregate(Emissions ~ year, coal, sum)

# open png device
png(filename = pngFile, width = 480, height = 480)

# plot
barplot(height = agg$Emissions, horiz = FALSE, names.arg=agg$year, width = 1, main = "Coal Emissions by Year",
        xlab = "Year", ylab = "Emissions (Tons)")

# save png file
dev.off()

