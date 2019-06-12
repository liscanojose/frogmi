class CreateFeatures < ActiveRecord::Migration[5.2]
  def change
    create_table :features do |t|
      t.string :f_id
      t.float :mag
      t.integer :time
      t.string :url
      t.string :mag_type
      t.float :longitude
      t.float :latitude

      t.timestamps
    end
  end
end
