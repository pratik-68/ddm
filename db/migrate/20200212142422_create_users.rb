# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :mobile_number, null: false, limit: 10
      t.text :address, null: false

      ## Database authenticatable
      t.string :email, null: false
      t.string :password_digest, null: false

      ## 0 => Buyer, 1 => Seller, 2 => Both, 3 => Admin
      t.integer :type_of_user, null: false, default: 0

      ## 0 => Inactive User, 1 => Active User
      t.integer :is_active, null: false, default: 0

      ## Invite Count set to 0 when last invite is lower than current date
      t.integer :invite_count, null: false, default: 0
      t.date :last_invite_at, default: Time.current

      ## Recoverable
      t.string :reset_password_token
      t.datetime :reset_password_sent_at

      ## Trackable
      t.datetime :last_sign_in
      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :mobile_number, unique: true
  end
end
