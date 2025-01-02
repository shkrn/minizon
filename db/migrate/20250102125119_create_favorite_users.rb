class CreateFavoriteUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :favorite_users do |t|
      t.references :user, null: false, foreign_key: true
      #t.integer :favorite_user_id, null: false
      t.references :favorite_user, null: false, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
