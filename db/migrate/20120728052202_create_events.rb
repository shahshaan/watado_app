class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :location
      t.date :date
      t.time :start_time
      t.time :end_time
      t.string :image
      t.string :category
      t.string :name
      t.string :url
      t.string :venue
      t.integer :zipcode

      t.timestamps
    end
  end
end
