class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.decimal :isbn, precision: 13, null: false
      t.string :category, null: false
      t.string :title, null: false
      t.string :publisher, null: false
      t.decimal :year, precision: 4, null: false
      t.string :author, null: false
      t.decimal :price, precision: 7, scale: 2, null: false
      t.integer :total_storage, null: false
      t.integer :storage, null: false

      t.timestamps null: false
    end

    add_index :books, :title
    add_index :books, :isbn, unique: true
  end
end
