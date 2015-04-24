setwd("/Users/WanRong/ExploratoryDA2/ExploratoryDA2")

## Read RDS
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Get Baltimore's emissions data
baltimore_emissions <- NEI[NEI$fips=="24510",]

# Aggregate emissions: sum the Baltimore emissions by year
agg_baltimore <- aggregate(Emissions ~ year, baltimore_emissions, sum)

# Plot 3
install.packages("ggplot2")

png("plot3.png", width=480, height=480, units="px", bg="transparent")

library(ggplot2)
plot3 <- ggplot(baltimore_emissions, aes(factor(year), Emissions, fill=type)) +
    geom_bar(stat="identity") +
    theme_bw() + guides(fill=FALSE)+
    facet_grid(.~type, scales="free", space="free") + 
    labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
    labs(title=expression("PM"[2.5]*" Emissions, Baltimore City (1999-2008)"))

print(plot3)

dev.off()