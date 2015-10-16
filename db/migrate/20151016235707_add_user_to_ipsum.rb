class AddUserToIpsum < ActiveRecord::Migration
  def change
    add_reference :ipsums, :user, index: true
  end
end
