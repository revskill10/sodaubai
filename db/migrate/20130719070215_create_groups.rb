class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :lop_mon_hoc_id

      t.timestamps
    end
  end
end
