class CreateLichTrucNhats < ActiveRecord::Migration
  def change
    create_table :lich_truc_nhats do |t|
      t.datetime :ngay_truc
      t.string :phong
      t.integer :lop_mon_hoc_id

      t.timestamps
    end
  end
end
