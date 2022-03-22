class Stock < ActiveRecord::Base
    has_many :prices
    has_many :positions
    has_many :portfolios, through: :positions
end