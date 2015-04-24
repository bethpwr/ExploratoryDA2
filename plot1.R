
setwd("/Users/WanRong/ExploratoryDA2/ExploratoryDA2")

## Read RDS
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Aggregate emissions: sum the total emissions by year
agg_emissions <- aggregate(Emissions ~ year, NEI, sum)

# Plot 1
png("plot1.png", width=480, height=480, units="px", bg="transparent")

barplot(
    (agg_emissions$Emissions)/10^6,
    names.arg = agg_emissions$year,
    xlab= "Year",
    ylab= "PM2.5 Emissions (10^6 Tons)",
    main= "Total PM2.5 Emissions from the United States"
    )

dev.off()
