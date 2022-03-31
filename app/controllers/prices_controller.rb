class PricesController < ApplicationController
    set :default_content_type, 'application/json'
    
    #GET: /prices
    get "/prices" do
        Price.all.to_json
    end

    #GET: /prices/id
    get "/prices/:id" do
        find_price
        if @price
            @price.to_json
        else
            {errors: "No price found with id: #{params[:id]}"}.to_json
        end
    end

    #GET: /prices/stock_id
    get "/prices_by_stock_id/:stock_id" do 
        find_prices_by_stock_id
        if @prices
            @prices.to_json
        else
            {errors: "No prices found belonging to stock id: #{params[:stock_id]}"}.to_json
        end
    end

    #POST: /prices
    post "/prices" do
        Price.create(params).to_json
    end
    #POST: /prices_by_stock_id/stock_id
    post "/prices_by_stock_id/:id" do
        find_stock
        @stock.to_json
        symbol = @stock[:symbol]
        stock_id = @stock[:id]

        response = RestClient.get "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=#{symbol}&apikey=LOOC2YV5NOI7NALE"

        stock_hash = JSON.parse(response)

        stock_hash["Time Series (Daily)"].each do |date, info|

            Price.create(
                stock_id: stock_id,
                symbol: symbol,
                date: date,
                open: info["1. open"],
                high: info["2. high"],
                low: info["3. low"],
                close: info["4. close"],
                volume: info["5. volume"]
            )
        end
    end

    #DELETE: /prices/id
    delete "/prices/:id" do
        find_price
        if @price&.destroy
            {messages: "Price id: #{params[:id]} destroyed"}.to_json
        else
            {errors: "No price found with id: #{params[:id]}"}.to_json
        end
    end

    # #DELETE: /prices_by_stock_id/stock_id
    # delete "/prices_by_stock_id/:stock_id" do
    #     @prices
    # end
    
    private

    def find_price
        @price = Price.find_by_id(params[:id])
    end

    def find_prices_by_stock_id
        @prices = Price.where(stock_id: params[:stock_id])
    end

    def find_stock
        @stock = Stock.find_by_id(params[:id])
    end
end