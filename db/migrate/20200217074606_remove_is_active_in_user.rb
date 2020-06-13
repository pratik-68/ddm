class RemoveIsActiveInUser < ActiveRecord::Migration[5.2]
  def up
    remove_column :users, :is_active
  end

  def down
    add_column :users, :is_active, :integer, default: 0
  end
end
