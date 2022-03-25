class PositionsController < ApplicationController
    set :default_content_type, 'application/json'
    
    #GET: /positions
    get "/positions" do
        Position.all.to_json
    end

    #GET: /positions/id
    get "/positions/:id" do
        Position.find(params[:id]).to_json
    end

    #POST: /positions
    post "/positions" do
        Position.create(params).to_json
    end

    #DELETE: /positions/id
    delete "/positions/:id" do
        Position.find(params[:id]).destroy.to_json
    end
  
end