class Portfolio < ActiveRecord::Base
    has_many :positions
    has_many :stocks, through: :positions
    has_many :prices, through: :stocks

    validates :name, uniqueness: true
end