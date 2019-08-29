## RBingAds - R interface for the Bing Ads API

### Introduction

Welcome to the official documentation of the **RBingAds** package for **Bing Ads**. RBingAds enables users of the R Language for Statistical Computing to directly access their Bing Ads account in order to consume and analyze information provided by the Bing Ads API. **RBingAds** is a license cost free open source project by [Johannes Burkhardt](https://github.com/jburkhardt).

### Requirements

In order to use the **RBingAds** package you need to have access to the **Bing Ads API**. You will need following credentials and information:

- client id
- client secret
- API developer token
- admin email login with password
- customer / manager id
- account id

### Installation

```r
require(devtools)
install_github("jburkhardt/RBingAds")
```

### Authentication

The authentication requires a **client id**, a **client secret** and the **API developer token** from the API project (app, SDK). Furthermore, you need an **admin email** with **login credentials / password** for a one time authentication including user interaction in the webbrowser.

```r
library(RBingAds)
bing_auth <- authenticate(save = T)
```

### Load Data

The function `load_bing_data` takes over the complete data retrieval process with the Bing Ads API. If you have a valid `bing_auth` object, your **customer id** and a corresponding **account id**, you can select a report and define the query with metrics, attributes and dates. `load_bing_data` returns the data as a R dataframe.

```r
data <- load_bing_data(bing_auth = bing_auth,
                       customer_id = "******",
                       account_id = "*******",
                       report = "CampaignPerformanceReport",
                       columns = c("AccountName", "CampaignName",
                                    "TimePeriod", "Impressions",
                                    "Clicks", "Spend", "Conversions"),
                       start = "2019-01-01",
                       end = "2019-01-31")
```

### Development

The development of the package takes place on github in the repository [RBingAds](https://github.com/jburkhardt/RBingAds) maintained by [Johannes Burkhardt](https://github.com/jburkhardt).

#### Contribution

We are happy if you want to contribute to the package! The easiest way to collaborate is to fork the repository and develope new features or bug fix on a separate branch.

#### Bug Reporting

Please use the issue tracker of the Gihub repository: [RBingAds Issue Tracker](https://github.com/jburkhardt/RBingAds/issues)

We appreciate if you provide the following information along with the issue:

- Operating System
- R Version
- RBingAds package version
- the R code which leads to the error
- the error message, prompt output
- code as text rather than screenshot

### Acknowledgement

I would like to express my deep gratitude to [Deepesh Goel](https://github.com/deepeshgoeliitk). His previous work on the Bing Ads API and related xml parsing was the key to develop this package.
