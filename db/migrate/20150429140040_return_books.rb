class ReturnBooks < ActiveRecord::Migration
  def change
    add_column :records, :to_return_at, :datetime
    Record.all.each do |record|
      record.update(to_return_at: record.created_at + 30.days)
    end
  end
end
