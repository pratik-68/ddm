class CreateGroupBuyings < ActiveRecord::Migration[5.2]
  def change
    create_table :group_buyings do |t|
      t.integer :quantity, default: 0

      t.timestamps
    end
    add_reference :group_buyings, :user, foreign_key: true
    add_reference :group_buyings, :item, foreign_key: true
  end
end
