class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.decimal :isbn, precision: 13
      t.string :category
      t.string :title
      t.string :publisher
      t.decimal :year, precision: 4
      t.string :author
      t.decimal :price, precision: 7, scale: 2
      t.integer :total_storage
      t.integer :storage

      t.timestamps null: false
    end

    add_index :books, :title
    add_index :books, :isbn, unique: true
  end
end
