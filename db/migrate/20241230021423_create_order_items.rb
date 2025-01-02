class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items do |t|
      
      t.references :order, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true

      t.integer :quantity, null: false
      t.integer :price, null: false
      t.integer :delivery, null: false, default: 0

      t.timestamps
    end
  end
end
