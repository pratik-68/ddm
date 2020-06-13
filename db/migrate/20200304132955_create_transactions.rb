class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      # 0 => Refund, 1 => Paid
      t.integer :transaction_type, null: false

      # 0 => pending, 1 => succeeded, 2 => failed
      t.integer :status, default: 0

      t.integer :amount, null: false, precision: 10, scale: 2, default: 0
      t.integer :paid_amount, precision: 10, scale: 2, default: 0
      t.string :transaction_id
      t.string :token, null: false, default: ''

      t.timestamps
    end
    add_reference :transactions, :user, foreign_key: true
  end
end
