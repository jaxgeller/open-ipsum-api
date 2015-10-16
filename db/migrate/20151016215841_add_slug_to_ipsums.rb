class AddSlugToIpsums < ActiveRecord::Migration
  def change
    add_column :ipsums, :slug, :string
    add_index :ipsums, :slug, unique: true
  end
end
