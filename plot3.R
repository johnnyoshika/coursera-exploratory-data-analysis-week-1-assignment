# Read data

x <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

x <- transform(x, POSIXct = strptime(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"))
x <- transform(x, Global_active_power = as.numeric(as.character(Global_active_power)))
x <- transform(x, Global_reactive_power = as.numeric(as.character(Global_reactive_power)))
x <- transform(x, Voltage = as.numeric(as.character(Voltage)))
x <- transform(x, Global_intensity = as.numeric(as.character(Global_intensity)))
x <- transform(x, Sub_metering_1 = as.numeric(as.character(Sub_metering_1)))
x <- transform(x, Sub_metering_2 = as.numeric(as.character(Sub_metering_2)))

y <- subset(x, POSIXct >= strptime("2007-02-01", format = "%Y-%m-%d") & POSIXct < strptime("2007-02-03", format = "%Y-%m-%d"))

# Plot

png("plot3.png")
plot(y$POSIXct, y$Sub_metering_1, xlab = "", ylab = "Energy sub metering", ylim = c(0, max(c(max(y$Sub_metering_1), max(y$Sub_metering_2), max(y$Sub_metering_3)))), type = "n")
lines(y$POSIXct, y$Sub_metering_1, col = "black")
lines(y$POSIXct, y$Sub_metering_2, col = "red")
lines(y$POSIXct, y$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1))
dev.off()