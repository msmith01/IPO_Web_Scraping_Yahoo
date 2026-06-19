# Yahoo Finance IPO Research

[![R](https://img.shields.io/badge/R-Analysis-276DC3?logo=r&logoColor=white)](https://www.r-project.org/)
[![Dataset](https://img.shields.io/badge/Dataset-2000--2018-0284c7)](yahoo_finance_IPOs_2000_2018.csv)
[![Research](https://img.shields.io/badge/Topic-IPO_Underpricing-111827)](#research-context)

An exploratory corporate-finance project that collects historical IPO calendar data from Yahoo Finance, joins IPO observations with first-day market prices, and studies initial returns across exchanges and regions.

The repository also contains a historical 2000–2018 dataset and PDF comparisons based on Yahoo Finance, Bloomberg, and Jay Ritter's IPO research data.

## Research questions

- How large are first-day IPO returns across markets?
- How does underpricing vary by exchange or region?
- How do Yahoo Finance-derived estimates compare with established IPO datasets?
- How much value may be “left on the table” between the offer price and first-day close?

## Repository contents

| File | Description |
|---|---|
| [`IPOscrapingYahooFinance`](IPOscrapingYahooFinance) | R script that retrieves IPO calendar pages, downloads market prices, calculates returns, filters exchanges, and exports results. |
| [`yahoo_finance_IPOs_2000_2018.csv`](yahoo_finance_IPOs_2000_2018.csv) | Historical Yahoo Finance IPO observations from 2000–2018. |
| [`Yahoo_finance_IPO_graphs.pdf`](Yahoo_finance_IPO_graphs.pdf) | Charts for Hong Kong, Shanghai, and U.S. observations. |
| [`JR_Ritter_IPO_graphs.pdf`](JR_Ritter_IPO_graphs.pdf) | Charts using Jay Ritter's U.S. IPO data. |
| [`Monthly_bloomberg_graphs.pdf`](Monthly_bloomberg_graphs.pdf) | 2018 Bloomberg-based charts for several international markets. |

## Method

The R workflow:

1. constructs daily Yahoo Finance IPO-calendar URLs for a configured date range;
2. reads and combines the returned HTML tables;
3. removes missing offer-price observations;
4. retrieves market prices with `tidyquant`;
5. joins IPO and price data by symbol and date;
6. calculates the first-day return as:

```text
(adjusted closing price / offer price) - 1
```

7. creates exchange-specific subsets;
8. exports selected results to an Excel workbook.

## Requirements

The script uses these R packages:

```r
install.packages(c(
  "rvest",
  "naniar",
  "tidyverse",
  "tidyquant",
  "lubridate",
  "xlsx"
))
```

The `xlsx` package may require a working Java installation.

## Usage

Clone the repository:

```bash
git clone https://github.com/msmith01/IPO_Web_Scraping_Yahoo.git
cd IPO_Web_Scraping_Yahoo
```

Open `IPOscrapingYahooFinance` in R or RStudio and review the configured dates:

```r
from <- "2017-01-01"
to <- "2018-09-13"
```

Then run the script:

```bash
Rscript IPOscrapingYahooFinance
```

The workflow creates exchange-specific data frames and writes selected sheets to `IPOs.xlsx`.

## Covered market filters

The current script includes filters for:

- Shanghai
- Hong Kong
- NYSE
- Euronext
- ASX
- Canadian Securities Exchange
- Amsterdam
- Nasdaq Global Market
- London Stock Exchange
- Paris
- Frankfurt

## Research context

IPO underpricing is commonly measured using the percentage change between the offer price and the first trading day's closing price. “Money left on the table” is commonly defined as that price difference multiplied by shares sold.

Useful references:

- [Jay Ritter's IPO data](https://site.warrington.ufl.edu/ritter/ipo-data/)
- [Loughran and Ritter, *Why Has IPO Underpricing Changed Over Time?*](https://site.warrington.ufl.edu/ritter/files/2016/06/why-has-IPO-Underpricing-Increased-Over-Time.pdf)
- [Money Left on the Table in IPOs by Firm](https://site.warrington.ufl.edu/ritter/files/2019/08/Monnew.pdf)

## Limitations

- This is historical research code and depends on Yahoo Finance page structures and endpoints that may have changed.
- Free Yahoo data can contain missing, inconsistent, or adjusted prices.
- Symbol reuse, delistings, exchange naming, corporate actions, and timezone differences can affect joins.
- Bloomberg, WRDS, exchange records, or specialist IPO databases are preferable for production-grade research.
- The repository does not currently include reproducible plotting source for every PDF artifact.

## Contributing

Issues and pull requests improving data validation, endpoint compatibility, reproducibility, or plotting code are welcome.

## License

No open-source license is currently included. Unless a license is added, the repository remains copyrighted and reuse is not automatically granted.
