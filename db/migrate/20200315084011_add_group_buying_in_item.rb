class AddGroupBuyingInItem < ActiveRecord::Migration[5.2]
  def up
    add_column :items, :group_buying, :integer, default: 0
    add_column :items, :quantity, :integer, default: 0
  end

  def down
    remove_column :items, :group_buying
    remove_column :items, :quantity
  end
end
