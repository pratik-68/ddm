class CreateVerifications < ActiveRecord::Migration[5.2]
  def change
    create_table :verifications do |t|
      t.string :email, null: false

      ## 0 => Pending, 1 => Accept
      t.integer :status, null: false, default: 0

      t.timestamps
    end
    add_index :verifications, :email, unique: true
  end
end
