class PositionsController < ApplicationController
    set :default_content_type, 'application/json'
    
    #GET: /stocks
    get "/positions" do
        Stock.all.to_json
    end

    #GET: /stocks/id
    get "/positions/:id" do
        Stock.find(params[:id]).to_json
    end

    #POST: /stocks
    post "/positions" do
        # response = RestClient.get "https://www.alphavantage.co/query?function=OVERVIEW&symbol=MSFT&apikey=LOOC2YV5NOI7NALE"
        Stock.create(params).to_json
    end

    #DELETE: /stocks/id
    delete "/positions/:id" do
        Stock.find(params[:id]).destroy.to_json
    end
  
end