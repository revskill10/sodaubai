class AddDaysToTuan < ActiveRecord::Migration
  def change
    add_column :tuans, :days, :text
  end
end
