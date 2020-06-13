class RenameLastUseInToken < ActiveRecord::Migration[5.2]
  def up
    rename_column :tokens, :last_use, :last_used_on
  end

  def down
    rename_column :tokens, :last_used_on, :last_use
  end
end
