library(tidyverse)
library(data.table)

setwd("~/Documents/datascience/eda/CourseProject2")
pngFile <- "plot6.png"

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# coal data
merged <- merge(NEI, SCC, by = "SCC")
cities <- subset(merged, fips == "24510" | fips == "06037")
cities <- data.table(cities)

vehicle <- cities[SCC.Level.Two %like% "Vehicle"]

# display data in kilo-tons
vehicle$Emissions <- vehicle$Emissions / 10^3

# open png device
png(filename = pngFile, width = 480, height = 480)

# plot
gp <- ggplot(vehicle, aes(year, Emissions, color = fips)) + geom_line(stat = "summary",fun.y = "sum") + 
    labs(x = "Year", y = "Emissions (Kilo-Tons)", title = "Motor Vehicle Emissions in Baltimore and Los Angeles") +
    scale_colour_discrete(name = "County", label = c("Los Angeles","Baltimore"))
print(gp)

# save png file
dev.off()

