class DropHanabiSpots < ActiveRecord::Migration[6.1]
  def change
    drop_table :hanabi_spots
  end
end
