class CreateLichTrinhGiangDays < ActiveRecord::Migration
  def change
    
    create_table :lich_trinh_giang_days do |t|
      t.string :ma_lop
      t.string :ma_mon_hoc
      t.string :nam_hoc
      t.integer :hoc_ky
      t.datetime :ngay_day
      t.text :noi_dung_day
      t.integer :so_tiet_day
      t.text :nhan_xet_buoi_hoc
      t.string :phong
      t.boolean :xac_nhan_sv

      t.timestamps
    end
  end
end
