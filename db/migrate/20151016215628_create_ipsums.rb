class CreateIpsums < ActiveRecord::Migration
  def change
    create_table :ipsums do |t|
      t.string :title
      t.text :text
      t.text :preview

      t.timestamps null: false
    end
  end
end
