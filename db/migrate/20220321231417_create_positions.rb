class CreatePositions < ActiveRecord::Migration[6.1]
  def change
    create_table :positions do |t|
      t.belongs_to :portfolio
      t.belongs_to :stock

      t.timestamps
    end
  end
end
