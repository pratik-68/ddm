class CreateItemGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :item_groups do |t|
      t.timestamps
    end
    add_reference :item_groups, :item, foreign_key: true
    add_reference :item_groups, :group, foreign_key: true
  end
end
