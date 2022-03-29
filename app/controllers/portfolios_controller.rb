class PortfoliosController < ApplicationController
    set :default_content_type, 'application/json'
    
    # GET: /portfolios
    get "/portfolios" do
      portfolios = Portfolio.all
      portfolios.to_json(include: { positions: { include: :stock } })
    end

    # GET: /portfolios/id
    get "/portfolios/:id" do
        portfolio = Portfolio.find(params[:id])
        portfolio.to_json(include: { positions: { include: :stock } })
    end

    #POST: /portfolios
    post "/portfolios" do
        Portfolio.create(params).to_json
    end

    #PATCH: /portfolios/id
    patch "/portfolios/:id" do 
        Portfolio.find(params[:id]).update(
            name: params[:name]
        ).to_json
    end

    #DELETE: /portfolios/id
    delete "/portfolios/:id" do
        Portfolio.find(params[:id]).destroy.to_json
    end
    
end