class CreateBidDescriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :bid_descriptions do |t|
      t.timestamps
      t.datetime :deleted_at
    end
    add_reference :bid_descriptions, :bid, foreign_key: true
    add_reference :bid_descriptions, :description, foreign_key: true
  end
end
