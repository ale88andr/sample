class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.references :hotel
      t.references :user
      t.integer :rate

      t.timestamps
    end
    add_index :rates, :hotel_id
    add_index :rates, :user_id
  end
end
