class CreateTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :tokens do |t|
      t.string :token, null: false
      t.datetime :last_use, null: false
      t.datetime :created_at, null: false
    end
    add_index :tokens, :token, unique: true
    add_reference :tokens, :user, foreign_key: true
  end
end
