library(dplyr)
install.packages("tidyr")
library(tidyr)
install.packages("lubridate")
library(lubridate)
df <- readRDS(df,file="Documents/Maxwell/Fall-2016/Data-Driven Managemant/FINAL PROJECT/NYC Bike Share Data.rds")
df <- separate(df, starttime, c("startdate", "starttime_insec"), sep=" ", remove =FALSE)
df$starttime_insec <- hm(df$starttime_insec)
df$startdate <- mdy(df$startdate)
df <- tbl_df(df)
df<- filter(df, birth.year >= 1930)
df<- select(df, bikeid, startdate, starttime_insec, start.station.id, end.station.id, start.station.name, end.station.name)
df<- df %>% arrange(bikeid,startdate, starttime_insec)
df<- mutate(df, repair= start.station.id==lag(end.station.id))
df<- group_by(df, bikeid)
df2<- summarise(df, count.repairs =sum(repair==FALSE, na.rm=T)-1)
View(df2)
summary(df2$count.repairs)
hist(df2$count.repairs,
     main="Average number of repairs per bike",
     xlab="Number of repairs",
     col = "olivedrab2")
abline(v=9.9,
       col="navy",
       lwd=2
       )