class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user
      t.references :hotel
      t.text :text

      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, :hotel_id
  end
end
