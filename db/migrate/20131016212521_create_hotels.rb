class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.string      :title,           null: false, default: ""
      t.integer     :star_rating,     null: false, default: 0
      t.boolean     :breakfast
      t.text        :room_description
      t.string      :photo
      t.float       :price_for_room
      t.string      :address
      t.references  :user

      t.timestamps
    end
    add_index :hotels, :title
    add_index :hotels, :user_id
  end
end
