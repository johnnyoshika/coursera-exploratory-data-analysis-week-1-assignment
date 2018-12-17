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

png("plot4.png")
par(mfrow = c(2, 2))
with(y, {
  plot(POSIXct, Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")
  
  plot(POSIXct, Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
  
  plot(POSIXct, Sub_metering_1, xlab = "", ylab = "Energy sub metering", ylim = c(0, max(c(max(y$Sub_metering_1), max(y$Sub_metering_2), max(y$Sub_metering_3)))), type = "n")
  lines(POSIXct, Sub_metering_1, col = "black")
  lines(POSIXct, Sub_metering_2, col = "red")
  lines(POSIXct, Sub_metering_3, col = "blue")
  legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1))
  
  plot(POSIXct, Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
})
dev.off()