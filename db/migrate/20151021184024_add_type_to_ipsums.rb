class AddTypeToIpsums < ActiveRecord::Migration
  def change
    add_column :ipsums, :g_markov, :boolean, default: true
end
