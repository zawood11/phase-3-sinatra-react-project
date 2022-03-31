class Price < ActiveRecord::Base
    belongs_to :stock

    validates :stock_id, uniqueness: { scope: :date}
end