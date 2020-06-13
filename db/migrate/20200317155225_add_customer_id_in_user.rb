class AddCustomerIdInUser < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :customer_id, :string, default: ''
  end

  def down
    remove_column :users, :customer_idq
  end
end
