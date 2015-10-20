class AddColumnViewsToUrl < ActiveRecord::Migration
  def change
    add_column :urls, :views, :integer, default: 0
  end
end
