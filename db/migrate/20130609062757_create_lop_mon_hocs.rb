class CreateLopMonHocs < ActiveRecord::Migration
  def change        
    create_table :lop_mon_hocs do |t|
      t.string :ma_lop
      t.string :ma_giang_vien
      t.string :ma_mon_hoc
      t.string :nam_hoc
      t.integer :hoc_ky
      t.integer :so_tiet
      t.integer :so_tuan_hoc
      t.datetime :ngay_bat_dau
      t.datetime :ngay_ket_thuc
      t.string :phong_hoc

      t.timestamps
    end
  end
end
