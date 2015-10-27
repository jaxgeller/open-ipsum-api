class AddGeneratedSampleToIpsums < ActiveRecord::Migration
  def change
    add_column :ipsums, :generated_sample, :string
  end
end
