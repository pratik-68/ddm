class AddTokenInVerification < ActiveRecord::Migration[5.2]
  def up
    add_column :verifications, :token, :string, null: false
  end

  def down
    remove_column :verifications, :token
  end
end
