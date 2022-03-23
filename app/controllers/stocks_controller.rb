class StocksController < ApplicationController
    set :default_content_type, 'application/json'
    
    #GET: /stocks
    get "/stocks" do
        Stocks.all.to_json
    end

    #GET: /stocks/id
    get "/stocks/:id" do
        Stocks.find(params[:id]).to_json
    end

    #POST: /stocks
    post "/stocks" do
        Stocks.create(params).to_json
    end

    #DELETE: /stocks/id
    delete "/stocks/id" do
        Stocks.find(params[:id]).destroy.to_json
    end
  
end