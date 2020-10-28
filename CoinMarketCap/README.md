# CMC 'IDEAL' API 

## Table of contents

- [Summary](#summary)
- [Standards and Conventions](#standards-and-conventions)
- [**\[Section A\]** **Spot Exchanges**](#section-a-spot-exchanges)
  - [Endpoint Overview](#endpoint-overview)
  - [Response Descriptons](#response-descriptons)
  - [Ticker](#ticker)
  - [Ticker response descriptions.](#ticker-response-descriptions)
  - [Order book response descriptions.](#order-book-response-descriptions)
  - [Trades response descriptions.](#trades-response-descriptions)
- [**\[Section B\]** **Derivative Exchanges**](#section-b-derivative-exchanges)
- [Derivative Exchanges](#derivative-exchanges)
  - [](#)
  - [**<span class="underline">Endpoint B1 (Contracts)</span>**](#span-classunderlineendpoint-b1-contractsspan)
  - [**<span class="underline">Endpoint B2 (Contract specifications)</span>**](#span-classunderlineendpoint-b2-contract-specificationsspan)
  - [**<span class="underline">Endpoint B3 (Order book)</span>**](#span-classunderlineendpoint-b3-order-bookspan)
- [**\[Section C\]** **AMM DEXes**](#section-c-amm-dexes)

## CMC API
**Ideal API Endpoint Samples**

**(Last Updated: 10 Jun 2020)**

**INTRODUCTION**

This API reference includes technical documentation needed to formulate/standardize exchange API endpoints. Outlined below are the **<span class="underline">recommended</span>** and **<span class="underline">mandatory</span>** requirements - please review carefully.

Exchanges are expected to **<span class="underline">minimally</span>** support the **<span class="underline">mandatory</span>** endpoints outlined below along with their corresponding mandatory data-points for integration.

## Summary 

**SUMMARY**

The public GET request endpoints are intended to allow access to market data. Endpoints return results in JSON format. Referenced in the /assets and /ticker endpoints is a Unified Cryptoasset ID (UCID). Please view [<span class="underline">this page</span>](https://docs.google.com/document/d/1a5JfNE8aXusvfZBnEokwzp1-vGNJ_SPo-jIXhfnnEYE/edit) for more information on the UCID.

-   [**<span class="underline">Section A:</span>** <span class="underline">Spot Exchanges API endpoints</span>](#kix.oo2warcvlj22)

-   [**<span class="underline">Section B:</span>** <span class="underline">Derivatives Exchanges API endpoints</span>](#kix.92jgzayiyaa)

-   [<span class="underline">**Section C:** AMM DEXes</span>](#kix.5p33g7oj0og8)

## Standards and Conventions 

**STANDARDS AND CONVENTIONS**

For exchanges looking to integrate with CoinMarketCap, here are some guidelines:

1.  A REST API with <span class="underline">no API authentication</span> required on market endpoints.

2.  Full market queries available every 60 seconds; We poll once per minute per market pair.

3.  Dash, hyphen, or underscore base\_quote pair notation. No base quote concatenation.

4.  Prices standardized to the quote currency.

5.  Data available in JSON format

6.  If applicable, turn Cloudflare security level to OFF for API endpoints. See this [<span class="underline">Cloudlfare Support Article</span>](https://support.cloudflare.com/hc/en-us/articles/200170056-What-does-Cloudflare-s-Security-Level-mean-) for more information.

7.  Versioning required to avoid breaking changes (api/v1/asset, api/v2/asset, etc.)

8.  Content encoding: gzip supported for optimized data transfer.

9.  No region blocked API endpoints or IP address whitelisting required, as we risk losing data from the exchange if we change IPs for data collection in the future.

## **\[Section A\]** **Spot Exchanges**

### Endpoint Overview 
**ENDPOINT OVERVIEW**

<table><thead><tr class="header"><th><strong>Name</strong></th><th><strong>Category</strong></th><th><strong>Status</strong></th><th><strong>Description</strong></th></tr></thead><tbody><tr class="odd"><td><p><a href="#kix.l9fkcvy68gv0"><span class="underline">Summary Endpoint</span></a></p><p>(See <a href="https://www.bitrue.com/kline-api/public.json?command=returnTicker">sample</a>)</p></td><td><span class="underline">Summary</span></td><td>Mandatory</td><td>Overview of market data for <strong><span class="underline">all</span></strong> tickers and <strong><span class="underline">all</span></strong> markets.</td></tr><tr class="even"><td><p><a href="#kix.lzf008k5nm6o"><span class="underline">Endpoint A1</span></a></p><p>(See <a href="https://poloniex.com/public?command=returnCurrencies">sample</a>)</p></td><td><span class="underline">asset</span></td><td>Recommended</td><td>In depth details on crypto currencies available on the exchange.</td></tr><tr class="odd"><td><p><a href="#kix.9r12wiruqkw4"><span class="underline">Endpoint A2</span></a></p><p>(See <a href="https://open.bkiex.com/api/allticker">sample</a>)</p></td><td><span class="underline">ticker</span></td><td>Mandatory</td><td>24-hour rolling window price change statistics for all markets.</td></tr><tr class="even"><td><p><a href="#kix.ojdax1m5sg58"><span class="underline">Endpoint A3</span></a></p><p>(See <a href="https://pub.bitnaru.com/v1/trades/ETH_BTC">sample</a>)</p></td><td><span class="underline">orderbook</span></td><td>Mandatory</td><td>Market depth of a trading pair. One array containing a list of ask prices and another array containing bid prices. Query for level 2 order book with full depth available as minimum requirement.</td></tr><tr class="odd"><td><p><a href="#kix.9sxaz61ixguo"><span class="underline">Endpoint A4</span></a></p><p>(See <a href="https://poloniex.com/public?command=returnCurrencies">sample</a>)</p></td><td><span class="underline">trades</span></td><td>Mandatory</td><td>Recently completed trades for a given market. 24 hour historical full trades available as minimum requirement.</td></tr></tbody></table>

**<span class="underline">SUMMARY ENDPOINT</span>**

The summary endpoint is to provide an overview of market data for **<span class="underline">all</span>** tickers and **<span class="underline">all</span>** market pairs on the exchange.


"**trading\_pairs**": "ETC\_BTC",

"**last\_price**": 0.00067,

"**lowest\_ask**": 0.000681,

"**highest\_bid**": 0.00067,

"**base\_volume**": 1528.11,

"**quote\_volume**": 1.0282814600000003,

"**price\_change\_percent\_24h**": -1.3254786450662739,

"**highest\_price\_24h**": 0.000676,

"**lowest\_price\_24h**": 0.000666

},
```json
{

"**trading\_pairs**": "XRP\_BTC",

"**last\_price**": 0.0000203,

"**lowest\_ask**": 0.0000213,

"**highest\_bid**": 0.0000202,

"**base\_volume**": 350700,

"**quote\_volume**": 7.139649999999999,

"**price\_change\_percent\_24h**": -0.49019607843137253,

"**highest\_price\_24h**": 0.0000204,

"**lowest\_price\_24h**": 0.0000203

},
```
```json
{

"**trading\_pairs**": "LTC\_BTC",

"**last\_price**": 0.00469,

"**lowest\_ask**": 0.00479,

"**highest\_bid**": 0.00469,

"**base\_volume**": 592.88,

"**quote\_volume**": 2.7840513999999996,

"**price\_change\_percent\_24h**": -0.635593220338983,

"**highest\_price\_24h**": 0.00471,

"**lowest\_price\_24h**": 0.00466

```

### Response Descriptons 

Summary response descriptions.

| **Name**                    | **Type** | **Status**  | **Description**                                                                                           |
|-----------------------------|----------|-------------|-----------------------------------------------------------------------------------------------------------|
| trading\_pairs              | string   | Mandatory   | Identifier of a ticker with delimiter to separate base/quote, eg. BTC-USD (Price of BTC is quoted in USD) |
| base\_currency              | string   | Recommended | Symbol/currency code of base currency, eg. BTC                                                            |
| quote\_currency             | string   | Recommended | Symbol/currency code of quote currency, eg. USD                                                           |
| last\_price                 | decimal  | Mandatory   | Last transacted price of base currency based on given quote currency                                      |
| lowest\_ask                 | decimal  | Mandatory   | Lowest Ask price of base currency based on given quote currency                                           |
| highest\_bid                | decimal  | Mandatory   | Highest bid price of base currency based on given quote currency                                          |
| base\_volume                | decimal  | Mandatory   | 24-hr volume of market pair denoted in BASE currency                                                      |
| quote\_volume               | decimal  | Mandatory   | 24-hr volume of market pair denoted in QUOTE currency                                                     |
| price\_change\_percent\_24h | decimal  | Mandatory   | 24-hr % price change of market pair                                                                       |
| highest\_price\_24h         | decimal  | Mandatory   | Highest price of base currency based on given quote currency in the last 24-hrs                           |
| lowest\_price\_24h          | decimal  | Mandatory   | Lowest price of base currency based on given quote currency in the last 24-hrs                            |

**<span class="underline">ENDPOINT A1</span>**

**ASSETS** /assets

The assets endpoint is to provide a detailed summary for each currency available on the exchange.

{

**"BTC"**:{

**"name"**:"bitcoin",

**"unified\_cryptoasset\_id"** :"1",

**"can\_withdraw"**:"true",

**"can\_deposit"**:"true",

**"min\_withdraw"**:"0.01",

**"max\_withdraw "**:"100"

**"name"**:"bitcoin",

**"maker\_fee"**:"0.01",

**"taker\_fee"**:"0.01",

},

**"ETH"**:{

**"name"**:"ethereum",

**"unified\_cryptoasset\_id"**:"1027",

**"can\_withdraw"**:"false",

**"can\_deposit"**:"false",

**"min\_withdraw"**:"10.00",

**"max\_withdraw "**:"0.00"

**"maker\_fee"**:"0.01",

**"taker\_fee"**:"0.01",

}

}

Assets response descriptions.

| **Name**                                                                                                                                        | **Type** | **Status**  | **Description**                                                                                                                                                                                                           |
|-------------------------------------------------------------------------------------------------------------------------------------------------|----------|-------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| name                                                                                                                                            | string   | Recommended | **<span class="underline">Full name</span>** of cryptocurrency.                                                                                                                                                           |
| [<span class="underline">unified\_cryptoasset\_id</span>](https://docs.google.com/document/d/1a5JfNE8aXusvfZBnEokwzp1-vGNJ_SPo-jIXhfnnEYE/edit) | integer  | Recommended | Unique ID of cryptocurrency assigned by [<span class="underline">Unified Cryptoasset ID</span>](https://pro-api.coinmarketcap.com/v1/cryptocurrency/map?CMC_PRO_API_KEY=UNIFIED-CRYPTOASSET-INDEX&listing_status=active). |
| can\_withdraw                                                                                                                                   | boolean  | Recommended | Identifies whether withdrawals are enabled or disabled.                                                                                                                                                                   |
| can\_deposit                                                                                                                                    | boolean  | Recommended | Identifies whether deposits are enabled or disabled.                                                                                                                                                                      |
| min\_withdraw                                                                                                                                   | decimal  | Recommended | Identifies the single minimum withdrawal amount of a cryptocurrency.                                                                                                                                                      |
| max\_withdraw                                                                                                                                   | decimal  | Recommended | Identifies the single maximum withdrawal amount of a cryptocurrency.                                                                                                                                                      |
| maker\_fee                                                                                                                                      | decimal  | Recommended | Fees applied when liquidity is added to the order book.                                                                                                                                                                   |
| taker\_fee                                                                                                                                      | decimal  | Recommended | Fees applied when liquidity is removed from the order book.                                                                                                                                                               |

**<span class="underline">ENDPOINT A2</span>**

### Ticker 

**TICKER** /ticker

The ticker endpoint is to provide a 24-hour pricing and volume summary for each market pair available on the exchange.

{

**"BTC\_USDT"**:{

**"base\_id"**:"1",

**"quote\_id"**:"825",

**"last\_price"**:"10000",

**"quote\_volume"**:"20000",

**"base\_volume"**:"2",

**"isFrozen"**:"0"

},

**"LTC\_BTC"**:{

**"base\_id"**:"2",

**"quote\_id"**:"1",

**"last\_price"**:"0.00699900",

**"base\_volume"**:"20028,526",

**"quote\_volume"**:"279594",

**"isFrozen"**:"0"

},

**"BNB\_BTC"**:{

**"base\_id"**:"1839",

**"quote\_id"**:"1",

**"last\_price"**:"0.00699900",

**"base\_volume"**:"53819",

**"quote\_volume"**:"99.3459",

**"isFrozen"**:"0"

}

}

### Ticker response descriptions.
Ticker response descriptions.

| **Name**      | **Type** | **Status**  | **Description**                                                                                                                                                                                  |
|---------------|----------|-------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| base\_id      | integer  | Recommended | The quote pair [<span class="underline">Unified Cryptoasset ID</span>](https://pro-api.coinmarketcap.com/v1/cryptocurrency/map?CMC_PRO_API_KEY=UNIFIED-CRYPTOASSET-INDEX&listing_status=active). |
| quote\_id     | integer  | Recommended | The base pair [<span class="underline">Unified Cryptoasset ID</span>](https://pro-api.coinmarketcap.com/v1/cryptocurrency/map?CMC_PRO_API_KEY=UNIFIED-CRYPTOASSET-INDEX&listing_status=active).  |
| last\_price   | decimal  | Mandatory   | Last transacted price of base currency based on given quote currency                                                                                                                             |
| base\_volume  | decimal  | Mandatory   | 24-hour trading volume denoted in BASE currency                                                                                                                                                  |
| quote\_volume | decimal  | Mandatory   | 24 hour trading volume denoted in QUOTE currency                                                                                                                                                 |
| isFrozen      | integer  | Recommended | Indicates if the market is currently enabled (0) or disabled (1).                                                                                                                                |

**<span class="underline">ENDPOINT A3</span>**

**ORDERBOOK** /orderbook/market\_pair

The order book endpoint is to provide a complete level 2 order book (arranged by best asks/bids) with full depth returned for a given market pair.

Parameters:

<table><thead><tr class="header"><th><strong>Name</strong></th><th><strong>Type</strong></th><th><strong>Status</strong></th><th><strong>Description</strong></th></tr></thead><tbody><tr class="odd"><td>market_pair</td><td>string</td><td>Mandatory</td><td>A pair such as “LTC_BTC”</td></tr><tr class="even"><td>depth</td><td>int</td><td>Recommended (used to calculate liquidity score for rankings)</td><td><p>Orders depth quantity: [0,5,10,20,50,100,500]</p><p>Not defined or 0 = full order book</p><p>Depth = 100 means 50 for each bid/ask side.</p></td></tr><tr class="odd"><td>level</td><td>int</td><td><p>Recommended</p><p>(used to calculate liquidity score for rankings)</p></td><td><p>Level 1 – Only the best bid and ask.</p><p>Level 2 – Arranged by best bids and asks.</p><p>Level 3 – Complete order book, no aggregation.</p></td></tr></tbody></table>

{

**"timestamp"**:"‭1585177482652‬",

**"bids"**:\[

\[

"12462000",

"0.04548320"

\],

\[

"12457000",

"3.00000000"

\]

\],

**"asks"**:\[

\[

"12506000",

"2.73042000"

\],

\[

"12508000",

"0.33660000"

\]

\]

}

### Order book response descriptions.

Order book response descriptions.

<table><thead><tr class="header"><th><strong>Name</strong></th><th><strong>Type</strong></th><th><strong>Status</strong></th><th><strong>Description</strong></th></tr></thead><tbody><tr class="odd"><td>timestamp</td><td><p>Integer</p><p>(UTC timestamp in ms)</p></td><td>Mandatory</td><td>Unix timestamp in milliseconds for when the last updated time occurred.</td></tr><tr class="even"><td>bids</td><td>decimal</td><td>Mandatory</td><td>An array containing 2 elements. The offer price and quantity for each bid order.</td></tr><tr class="odd"><td>asks</td><td>decimal</td><td>Mandatory</td><td>An array containing 2 elements. The ask price and quantity for each ask order.</td></tr></tbody></table>

**<span class="underline">ENDPOINT A4</span>**

**TRADES** /trades/market\_pair

The trades endpoint is to return data on all recently completed trades for a given market pair.

Parameters:

| **Name**     | **Type** | **Status** | **Description**          |
|--------------|----------|------------|--------------------------|
| market\_pair | string   | Mandatory  | A pair such as LTC\_BTC. |

\[

{

**"trade\_id"**:3523643,

**"price"**:"0.01",

**"base\_volume"**:"569000",

**"quote\_volume"**:"0.01000000",

**"timestamp"**:"‭1585177482652‬",

**"type"**:"sell"

}

\]

### Trades response descriptions.

Trades response descriptions.

<table><thead><tr class="header"><th><strong>Name</strong></th><th><strong>Type</strong></th><th><strong>Status</strong></th><th><strong>Description</strong></th></tr></thead><tbody><tr class="odd"><td>trade_id</td><td>integer</td><td>Mandatory</td><td><p>A unique ID associated with the trade for the currency pair transaction</p><p><em>Note:</em> Unix timestamp does not qualify as trade_id.</p></td></tr><tr class="even"><td>price</td><td>decimal</td><td>Mandatory</td><td>Last transacted price of base currency based on given quote currency</td></tr><tr class="odd"><td>base_volume</td><td>decimal</td><td>Mandatory</td><td>Transaction amount in BASE currency.</td></tr><tr class="even"><td>quote_volume</td><td>decimal</td><td>Mandatory</td><td>Transaction amount in QUOTE currency.</td></tr><tr class="odd"><td>timestamp</td><td><p>Integer</p><p>(UTC timestamp in ms)</p></td><td>Mandatory</td><td>Unix timestamp in milliseconds for when the transaction occurred.</td></tr><tr class="even"><td>type</td><td>string</td><td>Mandatory</td><td><p>Used to determine whether or not the transaction originated as a buy or sell.</p><p>Buy – Identifies an ask was removed from the order book.</p><p>Sell – Identifies a bid was removed from the order book.</p></td></tr></tbody></table>

1.  

## **\[Section B\]** **Derivative Exchanges**

## Derivative Exchanges

**ENDPOINT OVERVIEW**

<table><thead><tr class="header"><th><strong>Name</strong></th><th><strong>Category</strong></th><th><strong>Status</strong></th><th><strong>Description</strong></th></tr></thead><tbody><tr class="odd"><td><p><a href="#kix.vhax3ywehyky"><span class="underline">Endpoint B1</span></a></p><p>(See <a href="https://ftx.com/api/futures,%20https://ftx.com/api/futures/BTC-PERP/stats"><span class="underline">sample</span></a>)</p></td><td>contracts</td><td>Mandatory</td><td><p>Summary of contracts traded on the exchange, helps to differentiate between different products available.</p><p>Ideally, all information should be returned in a single endpoint.</p></td></tr><tr class="even"><td><a href="#kix.tdsggzkbyb5h"><span class="underline">Endpoint B2</span></a></td><td>contract_specs</td><td>Mandatory</td><td><p>Describes the specification of the contracts, mainly the pricing of the contract and its type (vanilla, inverse, or quanto).</p><p>Note: Endpoint B2 may be combined with Endpoint B1 for ease of reference.</p></td></tr><tr class="odd"><td><p><a href="#kix.3pqork81s73e"><span class="underline">Endpoint B3</span></a></p><p>(See <a href="https://ftx.com/api/markets/BTC-PERP/orderbook?depth=100">sample</a>)</p></td><td>orderbook</td><td>Mandatory</td><td>Order book depth of any given trading pair, split into two different arrays for bid and ask orders.</td></tr></tbody></table>

###  

### **<span class="underline">Endpoint B1 (Contracts)</span>**

Endpoint B2 provides a summary of **<span class="underline">every single</span>** contract traded on the exchange. There should be a clear delineation between the contract type (e.g. perpetual, futures, options). Ideally, all information should be returned in a single endpoint.

<table><thead><tr class="header"><th><strong>Name</strong></th><th><strong>Type</strong></th><th><strong>Status</strong></th><th><strong>Description</strong></th></tr></thead><tbody><tr class="odd"><td>ticker_id</td><td>string</td><td>Mandatory</td><td>Identifier of a ticker with delimiter to separate base/quote, eg. BTC-PERPUSD, BTC-PERPETH, BTC-PERPEUR</td></tr><tr class="even"><td>base_currency</td><td>string</td><td>Mandatory</td><td>Symbol/currency code of base pair, eg. BTC</td></tr><tr class="odd"><td>quote_currency</td><td>string</td><td>Mandatory</td><td>Symbol/currency code of quote pair, eg. ETH</td></tr><tr class="even"><td>last_price</td><td>decimal</td><td>Mandatory</td><td>Last transacted price of base currency based on given quote currency</td></tr><tr class="odd"><td>base_volume</td><td>decimal</td><td>Mandatory</td><td>24 hour trading volume in BASE currency</td></tr><tr class="even"><td>USD_volume</td><td>decimal</td><td>Recommended</td><td>24 hour trading volume in USD</td></tr><tr class="odd"><td>quote_volume</td><td>decimal</td><td>Mandatory</td><td>24 hour trading volume in QUOTE currency</td></tr><tr class="even"><td>bid</td><td>decimal</td><td>Mandatory</td><td>Current highest bid price</td></tr><tr class="odd"><td>ask</td><td>decimal</td><td>Mandatory</td><td>Current lowest ask price</td></tr><tr class="even"><td>high</td><td>decimal</td><td>Mandatory</td><td>Rolling 24-hour highest transaction price</td></tr><tr class="odd"><td>low</td><td>decimal</td><td>Mandatory</td><td>Rolling 24-hour lowest transaction price</td></tr><tr class="even"><td>product_type</td><td>string</td><td>Mandatory</td><td>Futures, Perpetual, Options</td></tr><tr class="odd"><td>open_interest</td><td>decimal</td><td>Mandatory</td><td>The number of outstanding derivatives contracts that have not been settled</td></tr><tr class="even"><td>open_interest_usd</td><td>decimal</td><td>Recommended</td><td>The sum of the Open Positions (long or short) in USD Value of the contract</td></tr><tr class="odd"><td>index_price</td><td>decimal</td><td>Mandatory</td><td>Last calculated index price for underlying of contract</td></tr><tr class="even"><td>creation_timestamp</td><td><p>Integer</p><p>(UTC timestamp in ms)</p></td><td><p>Mandatory</p><p>(only for expirable futures/options)</p></td><td>Start date of derivative (<strong><span class="underline">not needed for perpetual swaps</span></strong>)</td></tr><tr class="odd"><td>expiry_timestamp</td><td><p>Integer</p><p>(UTC timestamp in ms)</p></td><td><p>Mandatory</p><p>(only for expirable futures/options)</p></td><td>End date of derivative (<strong><span class="underline">not needed for perpetual swaps</span></strong>)</td></tr><tr class="even"><td>funding_rate</td><td>decimal</td><td>Mandatory</td><td>Current funding rate</td></tr><tr class="odd"><td>next_funding_rate</td><td>decimal</td><td>Recommended</td><td>Upcoming predicted funding rate</td></tr><tr class="even"><td>next_funding_rate_timestamp</td><td><p>Integer</p><p>(UTC timestamp in ms)</p></td><td>Mandatory</td><td>Timestamp of the next funding rate change</td></tr><tr class="odd"><td>maker_fee</td><td>decimal</td><td>Recommended</td><td>Fees for filling a “maker” order (can be negative if rebate is given)</td></tr><tr class="even"><td>taker_fee</td><td>decimal</td><td>Recommended</td><td>Fees for filling a “taker” order (can be negative if rebate is given)</td></tr></tbody></table>

### **<span class="underline">Endpoint B2 (Contract specifications)</span>**

Describes the specification of the contracts, mainly the pricing of the contract and its type (vanilla, inverse, or quanto). Endpoint B2 (contract\_specs) can be combined with endpoint B1 (contracts).

| Name                      | Data Type | Category  | Description                                                                       |
|---------------------------|-----------|-----------|-----------------------------------------------------------------------------------|
| contract\_type            | string    | Mandatory | Describes the type of contract - Vanilla, Inverse or Quanto?                      |
| contract\_price           | decimal   | Mandatory | Describes the price per contract.                                                 |
| contract\_price\_currency | string    | Mandatory | Describes the currency which the contract is priced in (e.g. USD, EUR, BTC, USDT) |

### **<span class="underline">Endpoint B3 (Order book)</span>**

Provide order book information with at least depth = 100 (50 each side) returned for a given market pair/ticker.

<table><thead><tr class="header"><th>Name</th><th>Data Type</th><th>Category</th><th>Description</th></tr></thead><tbody><tr class="odd"><td>ticker_id</td><td>string</td><td>Mandatory</td><td>A pair such as "BTC-PERPUSD", with delimiter between different cryptoassets</td></tr><tr class="even"><td>timestamp</td><td><p>Integer</p><p>(UTC timestamp in ms)</p></td><td>Mandatory</td><td>Unix timestamp in milliseconds for when the last updated time occurred.</td></tr><tr class="odd"><td>bids</td><td>decimal</td><td>Mandatory</td><td>An array containing 2 elements. The offer price and quantity fyor each bid order</td></tr><tr class="even"><td>asks</td><td>decimal</td><td>Mandatory</td><td>An array containing 2 elements. The ask price and quantity for each ask order</td></tr></tbody></table>

Order book depth of any given trading pair, split into two different arrays for bid and ask orders. This is similar to Endpoint A3 for spot markets.

## **\[Section C\]** **AMM DEXes**

1.  C1: Uniswap Sample

2.  C2: Subgraph Sample

**Uniswap Sample**

{

"0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599\_0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2": {

"base\_id": "0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599",

"base\_name": "Wrapped BTC",

"base\_symbol": "WBTC",

"quote\_id": "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2",

"quote\_name": "Wrapped Ether",

"quote\_symbol": "WETH",

"last\_price": "30.45692523596447546478",

"base\_volume": "1725.0451867",

"quote\_volume": "52450.878529932577252127"

},

"0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2\_0xdAC17F958D2ee523a2206206994597C13D831ec7": {

"base\_id": "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2",

"base\_name": "Wrapped Ether",

"base\_symbol": "WETH",

"quote\_id": "0xdAC17F958D2ee523a2206206994597C13D831ec7",

"quote\_name": "Tether USD",

"quote\_symbol": "USDT",

"last\_price": "345.2244580923542612263",

"base\_volume": "195644.931427163765765227",

"quote\_volume": "67443916.533922"

},

"0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48\_0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2": {

"base\_id": "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48",

"base\_name": "USD//C",

"base\_symbol": "USDC",

"quote\_id": "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2",

"quote\_name": "Wrapped Ether",

"quote\_symbol": "WETH",

"last\_price": "0.00290132977471109834",

"base\_volume": "73286693.891247",

"quote\_volume": "213019.935113092043898437"

**Subgraph Sample**

-   Open environment for querying data

-   A way to query <span class="underline">settled</span> transactions for all pairs with variables for price/volume/symbols/contracts/timestamps/decimals

-   Sample: [<span class="underline">https://api.thegraph.com/subgraphs/name/cryptomaniacszone/oneinchswapped3</span>](https://api.thegraph.com/subgraphs/name/cryptomaniacszone/oneinchswapped3)

-   Contract address for quote\_id & base\_id

-   Timestamp parameter for settled transactions

-   Decimals might be necessary per asset to normalize base/quote volume

**{ swaps(first: 3, orderBy: timestamp)**

**{**

**id**

**fromAmount**

**toAmount**

**timestamp**

**pair {**

**fromToken {**

**decimals**

**symbol**

**tradeVolume**

**}**

**toToken {**

**decimals**

**symbol**

**tradeVolume**

**}**

**}**

**}**

**}**

"data": {

"swaps": \[

{

"fromAmount": "10000000000000000",

"id": "0x26f1c14cc968d9a38ba9578b5d01a266097475116f0b3a4a87e2fb256ea3b604",

"pair": {

"fromToken": {

"decimals": 18,

"symbol": "ETH",

"tradeVolume": "5207944.760473916764396218"

},

"toToken": {

"decimals": 18,

"symbol": "SNX",

"tradeVolume": "33150454.565463180328974321"

}

},

"timestamp": "1569689186",

"toAmount": "3475232359783357069"

},

{

"fromAmount": "280000000000000000",

"id": "0x889164e561a65fdd3990af835b8a369f2849d16fe32b6085c74056d70de1e889",

"pair": {

"fromToken": {

"decimals": 18,

"symbol": "ETH",

"tradeVolume": "5207944.760473916764396218"

},

"toToken": {

"decimals": 9,

"symbol": "DGX",

"tradeVolume": "3028.465867692"

}

},

"timestamp": "1569689186",

"toAmount": "1054116024"

},

{

"fromAmount": "21475232359783357069",

"id": "0xca0b3ff308f38769ae82a2b9074b04eb80823f030e2e3f36777ecceace79db38",

"pair": {

"fromToken": {

"decimals": 18,

"symbol": "SNX",

"tradeVolume": "33150454.565463180328974321"

},

"toToken": {

"decimals": 18,

"symbol": "ETH",

"tradeVolume": "5207944.760473916764396218"

}

},

"timestamp": "1569689297",

"toAmount": "61421189600443173"

},
