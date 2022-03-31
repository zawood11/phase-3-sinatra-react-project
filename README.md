# Personal Market Research Application

## Getting Started
This application is built using a React frontend and Sinatra backend repository. Both repositories are required to utilize the application. You can find the frontend repository here: https://github.com/zawood11/phase-3-sinatra-react-project-frontend. Fork and clone both repos onto your local machine.

### rake server
Run rake server in the CLI in this folder to launch the Sinatra backend and allow communication to/from the client side.

## Description
This application is designed to allow the user to create and manage multiple portfolios, add/remove stocks to those portfolios, and pull in price data through an API integration with AlphaVantage. 

More information on AlphaVantage can be found here: https://www.alphavantage.co/. API Documentation here: https://www.alphavantage.co/documentation/.

Below is a brief overview of underlying elements that drive the application.

### Portfolios
Portfolios serve as the overlying element in this application, where stocks can be added to in order to create a position (Portfolio/Stock combination). Users may add, rename, or delete portfolios as needed.

### Stocks
Stocks may be added to the stock database by searching for a ticker/symbol. If that symbol is found in AlphaVantage's database, any company overview information will be pulled from AlphaVantage and added to your database. If no information is found, the stock ticker provided will still be added to your database for monitoring purposes, just without any relevant information.

### Prices
Price data will also be pulled from AlphaVantage by clicking the 'Load Price Data' button. If price data for that stock is available, the last 100 price data points will be pulled in. Due to server load and the amount of data for full price data retrieval, we do not allow all price history to be downloaded at this time. Please contact your system administrator as needed if you wish to load full price history for a stock.

### Positions
Positions are the specific entity that tie a portfolio and stock together. When a user adds a stock to a portfolio, a position is created. Users may add/remove positions to/from any existing portfolio. Please note that in order to a position to a portfolio, the desired stock must be created in the database first.

## Author/Scope
This application was created by Zach Underwood to satisfy the Phase 3 Project requirements for Flatiron School.