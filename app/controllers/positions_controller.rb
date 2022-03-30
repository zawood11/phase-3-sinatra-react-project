class PositionsController < ApplicationController
    set :default_content_type, 'application/json'
    
    #GET: /positions
    get "/positions" do
        Position.all.to_json(include: [:portfolio, :stock])
    end

    #GET: /positions/id
    get "/positions/:id" do
        find_position
        if @position
            @position.to_json(include: [:portfolio, :stock])
        else
            {errors: "No position found with id: #{params[:id]}"}.to_json
        end
    end

    #POST: /positions
    post "/positions" do
        Position.create(params).to_json
    end

    #DELETE: /positions/id
    delete "/positions/id" do
        find_position
        if @position&.destroy
            {messages: "Position id: #{params[:id]} destroyed"}.to_json
        else
            {errors: "No position found with id: #{params[:id]}"}.to_json
        end
    end
    
    private
    
    def find_position
        @position = Position.find_by_id(params[:id])
    end
end