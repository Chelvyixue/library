class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :name, null: false
      t.string :dept, null: false
      t.string :card_type, null: false

      t.timestamps null: false
    end
  end
end
