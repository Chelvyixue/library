class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.references :book, index: true, foreign_key: true
      t.references :card, index: true, foreign_key: true
      t.references :admin, index: true, foreign_key: true
      t.datetime :returned_at

      t.timestamps null: false
    end
  end
end
