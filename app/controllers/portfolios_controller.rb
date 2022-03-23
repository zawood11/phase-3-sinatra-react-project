class ApplicationController < Sinatra::Base
    set :default_content_type, 'application/json'
    
    # GET: /portfolios
    get "/portfolios" do
      Portfolio.all.to_json
    end
  
end