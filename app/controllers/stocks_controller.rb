class StocksController < ApplicationController
    set :default_content_type, 'application/json'
    
    #GET: /stocks
    get "/stocks" do
        stocks = Stock.all
        stocks.to_json(include: :prices)
    end

    #GET: /stocks/id
    get "/stocks/:id" do
        stock = Stock.find(params[:id])
        stock.to_json(include: :prices)
    end

    #POST: /stocks
    post "/stocks" do
        Stock.create(params).to_json
    end
    
    #PATCH: /stocks/id
    patch "/stocks/:id" do
        @stock = Stock.find(params[:id])
        symbol = @stock[:symbol]

        response = RestClient.get "https://www.alphavantage.co/query?function=OVERVIEW&symbol=#{symbol}&apikey=LOOC2YV5NOI7NALE"
        
        stock_hash = JSON.parse(response)
        stock_name = stock_hash["Name"] ? stock_hash["Name"] : "No information available"
        stock_description = stock_hash["Description"] ? stock_hash["Description"] : "No information available"

        @stock.update(
            name: stock_name,
            description: stock_description
        ).to_json

    end

    #DELETE: /stocks/id
    delete "/stocks/:id" do
        Stock.find(params[:id]).destroy.to_json
    end
  
end