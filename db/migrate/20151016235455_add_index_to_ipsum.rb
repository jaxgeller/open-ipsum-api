class AddIndexToIpsum < ActiveRecord::Migration
  def change
    add_index :ipsums, :title, unique: true
  end
end
