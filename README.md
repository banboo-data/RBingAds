## RBingAds

R interface for the Bing Ads API

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

### Bing Ads API Authentication

The authentication requires a **client id**, a **client secret** and the **API developer token** from the API project (app, SDK). Furthermore, you need an **admin email** with **login credentials / password** for a one time authentication including user interaction in the webbrowser.

```r
library(RBingAds)
bing_auth <- authenticate(save = T)
```

### Load Data

Loading data proceedes in three steps:

1. Generating a report id
2. Get a download url
3. Download the data

#### Generate Report ID

```r
report_id <- get_report_id(bing_auth = bing_auth,
                           customer_id = "*******",
                           account_id = "*******",
                           report = "CampaignPerformanceReport",
                           columns = c("AccountName", "CampaignName", "TimePeriod", "Impressions", "Clicks", "Spend", "Conversions"),
                           start = "2019-01-01",
                           end = "2019-01-31")
```

#### Get Download URL

```r
download_url <- get_download_url(bing_auth = bing_auth,
                                customer_id = "******",
                                account_id = "*******",
                                report_id = report_id)
```

#### Download Data

```r
data <- download_data(download_url = download_url)
```

### Acknowledgement

I would like to express my deep gratitude to [Deepesh Goel](https://github.com/deepeshgoeliitk). His previous work on the Bing Ads API and related xml parsing was the key to develop this package.
