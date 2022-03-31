class StocksController < ApplicationController
    set :default_content_type, 'application/json'
    
    #GET: /stocks
    get "/stocks" do
        Stock.all.to_json(include: :prices)
    end

    #GET: /stocks/id
    get "/stocks/:id" do
        find_stock
        if @stock
            @stock.to_json(include: :prices)
        else
            {errors: "No stock found with id: #{params[:id]}"}.to_json
        end
    end

    #POST: /stocks
    post "/stocks" do
        Stock.create(
            symbol: params[:symbol].upcase
        ).to_json
    end
    
    #PATCH: /stocks/id
    patch "/stocks/:id" do 
        find_stock
        if @stock
            @stock
        else {errors: "No stock found with id: #{params[:id]}"}.   to_json
        end

        symbol = @stock[:symbol]

        response = RestClient.get "https://www.alphavantage.co/query?function=OVERVIEW&symbol=#{symbol}&apikey=LOOC2YV5NOI7NALE"
        
        stock_hash = JSON.parse(response)
        stock_name = stock_hash["Name"] ? stock_hash["Name"] : "No information available"
        stock_description = stock_hash["Description"] ? stock_hash["Description"] : "No information available"

        @stock.update(
            name: stock_name,
            symbol: symbol,
            description: stock_description
        ).to_json
    end

    #DELETE: /stocks/id
    delete "/stocks/:id" do
        find_stock
        if @stock&.destroy
            {messages: "Stock id: #{params[:id]} destroyed"}.to_json
        else
            {errors: "No stock found with id: #{params[:id]}"}.to_json
        end
    end
    
    private

    def find_stock
        @stock = Stock.find_by_id(params[:id])
    end
end