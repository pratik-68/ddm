class UpdateLastInviteAtInUser < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :last_invite_at, :date, default: '1900-01-01'
  end

  def down
    change_column :users, :last_invite_at, :date, default: Data.current
  end
end
