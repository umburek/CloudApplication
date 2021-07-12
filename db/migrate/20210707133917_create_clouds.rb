class CreateClouds < ActiveRecord::Migration[6.1]
  def change
    create_table :clouds do |t|

      t.timestamps
    end
  end
end
