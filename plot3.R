library(tidyverse)

setwd("~/Documents/datascience/eda/CourseProject2")
pngFile <- "plot3.png"

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# baltimore data
baltimore <- subset(NEI, fips=="24510")
baltimore$Emissions <- baltimore$Emissions / 10^3

# open png device
png(filename = pngFile, width = 480, height = 480)

# plot
plot3 <- ggplot(data = baltimore, aes(x = factor(year), y = Emissions, fill = type)) +
    facet_grid(.~type) + 
    geom_bar(stat = "identity") +
    guides(fill = FALSE) +
    labs(x = "Year", y = "Emissions (Tons)", title = "Emissions in Baltimore By Type") 

print(plot3)


# save png file
dev.off()

