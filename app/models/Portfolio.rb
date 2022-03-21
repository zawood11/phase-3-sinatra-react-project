class Portfolio < ActiveRecord::Base
    has_many :positions
end