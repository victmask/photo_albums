class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.string :title
      t.integer :album_id
      t.text :description
      t.string :photographer
      t.string :image_path
      t.string :image_name

      t.timestamps
    end
  end

  def self.down
    drop_table :photos
  end
end
