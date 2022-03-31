class PortfoliosController < ApplicationController
    set :default_content_type, 'application/json'
    
    # GET: /portfolios
    get "/portfolios" do
      Portfolio.all.to_json(include: { positions: { include: :stock } })
    end

    # GET: /portfolios/id
    get "/portfolios/:id" do
        find_portfolio
        if @portfolio
            @portfolio.to_json(include: { positions: { include: :stock } })
        else 
            {errors: "No portfolio found with id: #{params[:id]}"}.to_json
        end
    end

    #POST: /portfolios
    post "/portfolios" do
        Portfolio.create(params).to_json
    end

    #PATCH: /portfolios/id
    patch "/portfolios/:id" do
        find_portfolio
        if @portfolio
            @portfolio.update(
                name: params[:name]
             ).to_json
        elsif !@portfolio
            {errors: "No portfolio found with id: #{params[:id]}"}.to_json
        end
    end

    #DELETE: /portfolios/id
    delete "/portfolios/:id" do
        find_portfolio
        if @portfolio&.destroy
            {messages: "Portfolio id: #{params[:id]} destroyed"}.to_json
        else
            {errors: "No portfolio found with id: #{params[:id]}"}.to_json
        end
    end
    
    private

    def find_portfolio 
        @portfolio = Portfolio.find_by_id(params[:id])
    end

end