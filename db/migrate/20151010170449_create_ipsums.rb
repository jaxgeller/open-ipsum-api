class CreateIpsums < ActiveRecord::Migration
  def change
    create_table :ipsums do |t|
      t.string :title
      t.text :text
      t.string :slug

      t.timestamps null: false
    end
    add_index :ipsums, :title, unique: true
    add_index :ipsums, :slug, unique: true
  end
end
