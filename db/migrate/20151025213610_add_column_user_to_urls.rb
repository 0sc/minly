class AddColumnUserToUrls < ActiveRecord::Migration
  def change
    add_reference :urls, :user, index: true
  end
end
