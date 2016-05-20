class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.timestamp :start
      t.timestamp :finish
      t.string :title
      t.text :description

      t.timestamps null: false
    end
  end
end
