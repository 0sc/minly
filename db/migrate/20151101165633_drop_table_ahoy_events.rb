class DropTableAhoyEvents < ActiveRecord::Migration
  def change
    drop_table :ahoy_events

    add_index :urls, :original
    add_index :urls, :shortened
  end
end
