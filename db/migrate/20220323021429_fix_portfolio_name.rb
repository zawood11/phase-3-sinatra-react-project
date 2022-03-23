class FixPortfolioName < ActiveRecord::Migration[6.1]
  def change
    rename_column :portfolios, :portfolio_name, :name
  end
end
