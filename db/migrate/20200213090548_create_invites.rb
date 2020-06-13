class CreateInvites < ActiveRecord::Migration[5.2]
  def change
    create_table :invites do |t|
      t.string :email, null: false

      ## 0 => Pending, 1 => Accept, 2 => Reject
      t.integer :status, null: false, default: 0

      t.timestamps
    end
    add_reference :invites, :user, foreign_key: true
  end
end
