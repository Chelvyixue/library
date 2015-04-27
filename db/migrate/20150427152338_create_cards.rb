class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :name
      t.string :dept
      t.string :card_type

      t.timestamps null: false
    end
  end
end
