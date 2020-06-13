class CreateItemDescriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :item_descriptions do |t|
      t.timestamps
    end
    add_reference :item_descriptions, :item, foreign_key: true
    add_reference :item_descriptions, :description, foreign_key: true
  end
end
