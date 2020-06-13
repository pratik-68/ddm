class CreateBidLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :bid_likes do |t|
      t.integer :like, default: 0, null: false

      t.timestamps
    end
    add_reference :bid_likes, :user, foreign_key: true
    add_reference :bid_likes, :bid, foreign_key: true
  end
end
