class AddTableCollagePhotos < ActiveRecord::Migration
  def change
    create_table :collagephotos do |t|
      t.string :image_url
      t.integer :user_id

      t.timestamps
    end

  end
end
