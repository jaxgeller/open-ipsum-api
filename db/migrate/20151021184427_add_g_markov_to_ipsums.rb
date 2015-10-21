class AddGMarkovToIpsums < ActiveRecord::Migration
  def change
    add_column :ipsums, :g_markov, :bool
  end
end
