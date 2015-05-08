#reading data and converting Date and Time
fname <- "household_power_consumption.txt"
df <- read.table(fname, header=TRUE, sep=";", na="?")

# convert date and time variables to Date/Time class
df$Time <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")
df$Date <- as.Date(df$Date, "%d/%m/%Y")
# only use data from the dates 2007-02-01 and 2007-02-02
dates <- as.Date(c("2007-02-01", "2007-02-02"), "%Y-%m-%d")
data <- subset(df, Date %in% dates)

#On my computer the default was not English:
loc <- "English_United States.1252"
if (Sys.getlocale("LC_TIME") != loc) {
  Sys.setlocale("LC_TIME", "English")
}

png("plot3.png", width = 480, height = 480)
plot(data$Time, data$Sub_metering_1, type="l", xlab = "", ylab="Energy sub metering", col = "Black")
lines(data$Time, data$Sub_metering_2, type = "l", col = "Red")
lines(data$Time, data$Sub_metering_3, type = "l", col = "Blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("Black", "Red", "Blue"), lty = 1 )
dev.off()