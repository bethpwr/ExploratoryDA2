setwd("/Users/WanRong/ExploratoryDA2/ExploratoryDA2")

## Read RDS
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Get Baltimore emissions from motor vehicle sources
baltimore_emissions <- NEI[(NEI$fips=="24510") & (NEI$type=="ON-ROAD"),]
agg_baltimore <- aggregate(Emissions ~ year, baltimore_emissions, sum)

# Get Los Angeles emissions from motor vehicle sources
LA_emissions <- NEI[(NEI$fips=="06037") & (NEI$type=="ON-ROAD"),]
agg_LA_emissions <- aggregate(Emissions ~ year, LA_emissions, sum)

agg_baltimore$County <- "Baltimore City, MD"
agg_LA_emissions$County <- "Los Angeles County, CA"
total_emissions <- rbind(agg_baltimore, agg_LA_emissions)

# Plot 6
png("plot6.png", width=480, height=480, units="px", bg="transparent")

library(ggplot2)

plot6 <- ggplot(total_emissions, aes(x=factor(year), y=Emissions, fill=County)) +
         geom_bar(stat="identity") + 
         facet_grid(County  ~ ., scales="free") +
         ylab("Total Emissions (tons)") + 
         xlab("Year") +
         ggtitle(expression("PM"[2.5]*" Motor Vehicle Emissions in Baltimore & LA (1999-2008)"))

print(plot6)
dev.off()
