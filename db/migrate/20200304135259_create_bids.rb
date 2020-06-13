class CreateBids < ActiveRecord::Migration[5.2]
  def change
    create_table :bids do |t|
      # 0 => Pending, 1 => Reject
      t.integer :status, default: 0
      t.datetime :deleted_at
      t.timestamps
    end
    add_reference :bids, :user, foreign_key: true
    add_reference :bids, :item, foreign_key: true
  end
end
