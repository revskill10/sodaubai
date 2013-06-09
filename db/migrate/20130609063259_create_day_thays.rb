class CreateDayThays < ActiveRecord::Migration
  def change
    create_table :day_thays do |t|
      t.string :ma_giang_vien
      t.string :ma_lop
      t.string :ma_mon_hoc
      t.string :nam_hoc
      t.integer :hoc_ky
      t.datetime :ngay_day
      t.string :phong

      t.timestamps
    end
  end
end
