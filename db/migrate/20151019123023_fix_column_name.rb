class FixColumnName < ActiveRecord::Migration
  def self.up
    rename_column :urls, :redirect, :shortened
  end

  def self.down
    rename_column :urls, :shortened, :redirect
  end
end
