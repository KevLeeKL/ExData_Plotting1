library(ggplot2)

data <- read.csv('household_power_consumption.txt',  header=T, sep=';', na.strings="?", 
                nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
data1 <- subset(data, Date %in% c("1/2/2007","2/2/2007"))

data1$Date <- as.Date(data1$Date,format = '%d/%m/%y')

# plot 1
png("Plot 1.png",
    width = 480,
    height = 480)
plot1 <- hist(data1$Global_active_power, main= "Global Active Power", 
              xlab= "Global Active Power (kilowatts)", ylab="Frequency", col="Red")
dev.off()

# plot 2
datetime <- strptime(paste(data1$Date, data1$Time, sep=" "), "%Y-%m-%d %H:%M:%S")
globalActivePower <- as.numeric(data1$Global_active_power)
png("Plot 2.png",
    width = 480,
    height = 480)
plot(datetime, globalActivePower, type="l", ylab="Global Active Power (kilowatts)")
dev.off()

#plot 3
subMetering1 <- as.numeric(data1$Sub_metering_1)
subMetering2 <- as.numeric(data1$Sub_metering_2)
subMetering3 <- as.numeric(data1$Sub_metering_3)

png("plot 3.png", 
    width=480, height=480)
plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="blue")
dev.off()

#plot 4
globalReactivePower <- as.numeric(data1$Global_reactive_power)
voltage <- as.numeric(data1$Voltage)

png("plot 4.png", 
    width=480, height=480)
par(mfrow = c(2, 2)) 

plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power", cex=0.2)

plot(datetime, voltage, type="l", xlab="datetime", ylab="Voltage")

plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

plot(datetime, globalReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off()

