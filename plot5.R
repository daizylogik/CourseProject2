library(tidyverse)
library(data.table)

setwd("~/Documents/datascience/eda/CourseProject2")
pngFile <- "plot5.png"

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# coal data
merged <- merge(NEI, SCC, by = "SCC")
baltimore <- subset(merged, fips=="24510")
baltimore <- data.table(baltimore)
vehicle <- baltimore[SCC.Level.Two %like% "Vehicle"]

# display data in tons
vehicle$Emissions <- vehicle$Emissions / 10^3

# sum the emissions from coal, by year
agg <-  aggregate(Emissions ~ year, vehicle, sum)

# open png device
png(filename = pngFile, width = 480, height = 480)

# plot
barplot(height = agg$Emissions, horiz = FALSE, names.arg=agg$year, width = 1, main = "Baltimore Motor Vehicle Emissions by Year",
        xlab = "Year", ylab = "Emissions (Tons)")

# save png file
dev.off()

