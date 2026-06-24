rm(list=ls())

library(rvest)
library(naniar)
library(tidyverse)

from = "2017-01-01"
to = "2017-01-13"

s <- seq(as.Date(from), as.Date(to), "days")
url <- "https://finance.yahoo.com/calendar/ipo?from="
links <- gsub(" ", "", paste(url,from,"&to=",to,"&day=",format(s, "%Y-%m-%d")))

store <- NULL
tbl <- NULL

for(i in links){
  store[[i]] = read_html(i) %>% 
    html_nodes("table") %>%
    html_nodes("td") %>%
    html_text()
  
  tbl[[i]] = as.data.frame(matrix(store[[i]], ncol=9, byrow=TRUE))
}


# list <- unlist(tbl, recursive = FALSE)
# df <- do.call("rbind", list)
df <- bind_rows(tbl)
# df <- df %>%
#   replace_with_na_all(condition = ~.x == "-")

# data <- df[!is.na(df$Price), ]


# library(tidyverse)

# US <- df %>%
#   filter(str_detect(Exchange, c("NYSE", "Nasdaq")))


library(tidyquant)

symbols <- df$Symbol
symbols <- symbols[symbols != ""] 

stocks <- symbols %>%
  tq_get("stock.prices",
         from = from,
         to = to)

#save(large_stocks.Rda)

library(lubridate)



data$Date <- mdy(data$Date)

x <- data %>%
  setNames(tolower(names(.))) %>%
  left_join(., stocks, by = c("symbol", "date"))

x <- x[!is.na(x$close), ]
x <- x[!duplicated(x), ]

x$price <- as.numeric(x$price)
x$returns <- ((x$adjusted / x$price) - 1)

#filter by exchanges
#Shanghai
shanghaiipo <- x %>%
  filter(str_detect(exchange, c("Shanghai"))) %>%
  arrange(date)

sum(shanghaiipo$returns) / nrow(shanghaiipo)

#HongKong

HKipo <- x %>%
  filter(str_detect(exchange, c("HKSE"))) %>%
  arrange(date)

sum(HKipo$returns) / nrow(HKipo)

#NYSE

NYSEipo <- x %>%
  filter(str_detect(exchange, c("NYSE"))) %>%
  arrange(date)

sum(NYSEipo$returns) / nrow(NYSEipo)
 
#Euronext

Euronextipo <- x %>%
  filter(str_detect(exchange, c("Euronext"))) %>%
  arrange(date)

sum(Euronextipo$returns) / nrow(Euronextipo)

#ASX
ASXipo <- x %>%
  filter(str_detect(exchange, c("ASX"))) %>%
  arrange(date)

sum(ASXipo$returns) / nrow(ASXipo)

#Canadian Sec

CanadianSecipo <- x %>%
  filter(str_detect(exchange, c("Canadian Sec"))) %>%
  arrange(date)

sum(CanadianSecipo$returns) / nrow(CanadianSecipo)

#Amsterdam
Amsterdamipo <- x %>%
  filter(str_detect(exchange, c("Amsterdam"))) %>%
  arrange(date)

sum(Amsterdamipo$returns) / nrow(Amsterdamipo)

#Oslo

#Istanbul

#Sao Paolo

#NasdaqGM

NasdaqGMipo <- x %>%
  filter(str_detect(exchange, c("NasdaqGM"))) %>%
  arrange(date)

sum(NasdaqGMipo$returns) / nrow(NasdaqGMipo)

#LSE
LSEipo <- x %>%
  filter(str_detect(exchange, c("LSE"))) %>%  # Note we had to "fix" the LSE prices
  filter(!price == 1) %>%
  mutate(price = price*100) %>%
  mutate(returns = (adjusted / price) - 1) %>%
  arrange(adjusted)

sum(LSEipo$returns) / nrow(LSEipo)

#Paris

Parisipo <- x %>%
  filter(str_detect(exchange, c("Paris"))) %>%
  arrange(date)

sum(Parisipo$returns) / nrow(Parisipo)

#Frankfurt
Frankfurtipo <- x %>%
  filter(str_detect(exchange, c("Frankfurt"))) %>%
  arrange(date)

sum(Frankfurtipo$returns) / nrow(Frankfurtipo)

getwd()

library(xlsx)
write.xlsx(HKipo, file = "IPOs.xlsx", sheetName="HKipo", append=TRUE)
write.xlsx(NYSEipo, file = "IPOs.xlsx", sheetName="NYSEipo", append=TRUE)
write.xlsx(Euronextipo, file = "IPOs.xlsx", sheetName="Euronextipo", append=TRUE)
write.xlsx(ASXipo, file = "IPOs.xlsx", sheetName="ASXipo", append=TRUE)
write.xlsx(CanadianSecipo, file = "IPOs.xlsx", sheetName="CanadianSecipo", append=TRUE)
write.xlsx(Amsterdamipo, file = "IPOs.xlsx", sheetName="Amsterdamipo", append=TRUE)
write.xlsx(NasdaqGMipo, file = "IPOs.xlsx", sheetName="NasdaqGMipo", append=TRUE)
write.xlsx(LSEipo, file = "IPOs.xlsx", sheetName="LSEipo", append=TRUE)
write.xlsx(Parisipo, file = "IPOs.xlsx", sheetName="Parisipo", append=TRUE)
write.xlsx(Frankfurtipo, file = "IPOs.xlsx", sheetName="Frankfurtipo", append=TRUE)
