class PricesController < ApplicationController
    set :default_content_type, 'application/json'
    
    #GET: /prices
    get "/prices" do
        Price.all.to_json
    end

    #GET: /prices/id
    get "/prices/:id" do
        Price.find(params[:id]).to_json
    end

    #POST: /prices
    post "/prices" do
        Price.create(params).to_json
    end

    #DELETE: /prices/id
    delete "/prices/:id" do
        Price.find(params[:id]).destroy.to_json
    end
  
end