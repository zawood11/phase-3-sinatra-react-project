class PortfoliosController < ApplicationController
    set :default_content_type, 'application/json'
    
    # GET: /portfolios
    get "/portfolios" do
      Portfolio.all.to_json
    end

    # GET: /portfolios/id
    get "/portfolios/:id" do
        Portfolio.find(params[:id]).to_json
    end

    #POST: /portfolios
    post "/portfolios" do
        Portfolio.create(params)
    end

    #PATCH: /portfolios/id
    patch "/portfolios/:id" do 
        Portfolio.find(params[:id]).update(
            name: params[:name]
        )
    end

    #DELETE: /portfolios/id
    delete "/portfolios/:id" do
        Portfolio.find(params[:id]).destroy
    end
    

end