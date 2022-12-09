
library(drought)
fit<-SDI(AnuRains$RAINFALL,ts=3) # Compute the 3 month drought index

newV <- as.vector(fit$SDI)
newV <- as.vector(t(fit$SDI))
newv2<-tail(newV,480)


AnuRains2<-tail(AnuRains,480)
AnuRains2$SPI<-newv2
View(AnuRains2)
spi.breaks <- c(-2.4,-2,-1.6,-1.3,-0.8,-0.5,0.5,0.8,1.3,1.6,2,2.4)
spi.cols <- colorRampPalette(c("darkred","red","yellow","white","green","blue","darkblue"),space="rgb")
spi.plot <- AnuRains2$SPI #convert list to matrix for plotting
spi.plot[(AnuRains2$SPI ==Inf)] <- 2.2 #necessary to remove Infs because ecdf is being used
spi.plot[(AnuRains2$SPI ==-Inf)] <- -2.2 #necessary to remove Infs because ecdf is being used

spi.cols <- c("darkred","red","yellow","white","green","blue","darkblue")

ggplot(AnuRains2) + 
aes(x = YEAR, y = MONTH, z = SPI, fill = SPI) + 
geom_tile()  + 
scale_fill_gradientn(colours = spi.cols ,breaks=spi.breaks)+
