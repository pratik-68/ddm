class AddReferenceTransactionToBid < ActiveRecord::Migration[5.2]
  def up
    add_reference :transactions, :bid, foreign_key: true
  end

  def down
    remove_reference :transactions, :bid, foreign_key: true
  end
end
