class CreateDescriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :descriptions do |t|
      t.string :label, null: false
      t.string :detail, null: false
      t.timestamps
    end
  end
end
