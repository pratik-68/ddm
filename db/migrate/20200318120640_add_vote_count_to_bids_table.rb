class AddVoteCountToBidsTable < ActiveRecord::Migration[5.2]
  def up
    add_column :bids, :vote_count, :integer, null: false, default: 0
  end

  def down
    remove_column :bids, :vote_count
  end
end
