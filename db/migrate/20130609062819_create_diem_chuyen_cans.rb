class CreateDiemChuyenCans < ActiveRecord::Migration
  def change
    create_table :diem_chuyen_cans do |t|
      t.string :ma_sinh_vien
      t.string :ma_lop
      t.string :ma_mon_hoc
      t.string :nam_hoc
      t.integer :hoc_ky
      t.integer :tong_so_tiet
      t.integer :tong_so_tiet_vang
      t.integer :diem

      t.timestamps
    end
  end
end
