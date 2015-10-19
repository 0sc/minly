class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :original
      t.string :redirect
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
