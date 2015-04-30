class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.references :book, index: true, foreign_key: true, null: false
      t.references :card, index: true, foreign_key: true, null: false
      t.references :admin, index: true, foreign_key: true, null: false
      t.datetime :returned_at
      t.datetime :to_return_at, null: false

      t.timestamps null: false
    end
  end
end
