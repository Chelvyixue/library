class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string :name, null: false
      t.string :password_digest, null: false
      t.string :email, null: false

      t.timestamps null: false
    end
    add_index :admins, :name, unique: true
  end
end
