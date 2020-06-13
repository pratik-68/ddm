class CreateGroupUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :group_users do |t|
      t.integer :user_type, null: false, default: 1
      t.timestamps
    end
    add_reference :group_users, :user, foreign_key: true
    add_reference :group_users, :group, foreign_key: true
  end
end
