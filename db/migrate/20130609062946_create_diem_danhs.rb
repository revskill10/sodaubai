class CreateDiemDanhs < ActiveRecord::Migration
  def change    
    create_table :diem_danhs do |t|
      t.string :ma_sinh_vien
      t.string :ma_lop
      t.string :ma_mon_hoc
      t.string :nam_hoc
      t.integer :hoc_ky
      t.datetime :ngay_vang
      t.integer :so_tiet_vang

      t.timestamps
    end
  end
end
