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
    post "/prices_by_stock_id/:stock_id" do
        find_prices_by_stock_id
        @prices.to_json
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
end