class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :full_name, null: false
      t.string :family_name, null: false
      t.string :given_name, null: false
      t.string :business_name, null: false, add_index: true, unique:true
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :address, null: false
      t.string :phonenumber, null: false
      t.integer :status, null: false
      
      t.timestamps
    end
  end
end
