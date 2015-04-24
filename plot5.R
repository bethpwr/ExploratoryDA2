setwd("/Users/WanRong/ExploratoryDA2/ExploratoryDA2")

## Read RDS
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Get Baltimore emissions from motor vehicle sources
baltimore_emissions <- NEI[(NEI$fips=="24510") & (NEI$type=="ON-ROAD"),]
agg_baltimore <- aggregate(Emissions ~ year, baltimore_emissions, sum)

# Plot 5
png("plot5.png",width=480,height=480,units="px",bg="transparent")

library(ggplot2)

plot5 <- ggplot(agg_baltimore, aes(x=factor(year), y=Emissions)) +
    geom_bar (stat="identity") +
    labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) +
    ggtitle("Emissions from motor vehicle sources in Baltimore City (1999-2008)")
    
print(plot5)
dev.off()