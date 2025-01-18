class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|

      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      
      t.string :name, null: false
      t.string :code, null: false
      t.integer :stock, null: false
      t.string :description, null: false
      t.boolean :new, null: false
      t.integer :status, null: false
      t.integer :price, null: false
      t.timestamps
    end
  end
end
