class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :deal_id
      t.string :fb_photo_id
      t.string :name
      t.string :image
      t.timestamps
    end
  end
end
