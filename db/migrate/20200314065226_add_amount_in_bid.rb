class AddAmountInBid < ActiveRecord::Migration[5.2]
  def up
    add_column :bids, :amount, :decimal, precision: 10, scale: 2, null: false, default: 0
    add_column :bids, :name, :string, null: false, default: ''
  end

  def down
    remove_column :bids, :amount
    remove_column :bids, :name
  end
end
