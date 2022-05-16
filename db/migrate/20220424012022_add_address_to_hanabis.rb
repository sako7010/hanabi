class AddAddressToHanabis < ActiveRecord::Migration[6.1]
  def change
    add_column :hanabis, :address, :text
  end
end
