class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.references :user, null: false, foreign_key: true
      t.references :item, null: true, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.text :message, null: false
      t.string :subject
      t.boolean :status, default: false
      t.timestamps
    end
  end
end
