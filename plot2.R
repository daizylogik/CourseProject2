library(tidyverse)

setwd("~/Documents/datascience/eda/CourseProject2")
pngFile <- "plot2.png"

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# baltimore data
baltimore <- subset(NEI, fips=="24510")

# sum the emissions from NEI, by year
agg <-  aggregate(Emissions ~ year, baltimore, sum)

# show emissions in kilo-tons
agg$Emissions <- agg$Emissions / 10^3


# open png device
png(filename = pngFile, width = 480, height = 480)

# plot
barplot(height = agg$Emissions, horiz = FALSE, names.arg=agg$year, width = 1, main = "Baltimore Emissions by Year",
        xlab = "Year", ylab = "Emissions (Kilo-Tons)")

# save png file
dev.off()

