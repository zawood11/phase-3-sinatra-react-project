class PositionsController < ApplicationController
    set :default_content_type, 'application/json'
    
    #GET: /positions
    get "/positions" do
        positions = Position.all
        positions.to_json(include: [:portfolio, :stock])
    end

    #GET: /positions/id
    get "/positions/:id" do
        position = Position.find(params[:id])
        position.to_json(include: [:portfolio, :stock])
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