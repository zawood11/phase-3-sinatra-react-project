class CreatePositions < ActiveRecord::Migration[6.1]
  def change
    create_table :positions do |t|
      t.integer :portfolio_id
      t.string :symbol

      t.timestamps
    end
  end
end
