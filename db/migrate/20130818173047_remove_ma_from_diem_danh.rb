class RemoveMaFromDiemDanh < ActiveRecord::Migration
  def change
  	remove_column :diem_danhs, :ma_lop
  	remove_column :diem_danhs, :ma_mon_hoc
  	remove_column :diem_danhs, :ma_giang_vien

  	remove_column :lich_trinh_giang_days, :ma_lop
  	remove_column :lich_trinh_giang_days, :ma_mon_hoc
  	remove_column :lich_trinh_giang_days, :so_tiet_day
  	remove_column :lich_trinh_giang_days, :phong
  	remove_column :lich_trinh_giang_days, :ma_giang_vien
  	remove_column :lich_trinh_giang_days, :siso
  	remove_column :lich_trinh_giang_days, :sv
  end
end
