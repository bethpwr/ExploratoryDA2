setwd("/Users/WanRong/ExploratoryDA2/ExploratoryDA2")

## Read RDS
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?
# Subset NEI data by Baltimore's fips.
baltimore_emissions <- NEI[NEI$fips=="24510",]

# Aggregate emissions: sum the Baltimore emissions by year
agg_baltimore <- aggregate(Emissions ~ year, baltimore_emissions, sum)

# Plot 2
png("plot2.png", width=480, height=480, units="px", bg="transparent")

barplot(
    agg_baltimore$Emissions,
    names.arg = agg_baltimore$year,
    xlab= "Year",
    ylab= "PM2.5 Emissions (Tons)",
    main= "Total PM2.5 Emissions From Baltimore City"
    )

dev.off()