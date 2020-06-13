class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.decimal :max_amount, null: false, precision: 10, scale: 2, default: 0
      t.integer :status, null: false
      t.datetime :bidding_end_time, null: false
      t.integer :winner_id
      t.datetime :deleted_at
      t.timestamps
    end
    add_reference :items, :user, foreign_key: true
  end
end
