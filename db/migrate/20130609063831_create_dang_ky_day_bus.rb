class CreateDangKyDayBus < ActiveRecord::Migration
  def change    
    create_table :dang_ky_day_bus do |t|
      t.string :ma_giang_vien
      t.string :ma_lop
      t.string :ma_mon_hoc
      t.string :nam_hoc
      t.integer :hoc_ky
      t.datetime :ngay_day_dang_ky
      t.integer :tiet_bat_dau
      t.string :phong

      t.timestamps
    end
  end
end
