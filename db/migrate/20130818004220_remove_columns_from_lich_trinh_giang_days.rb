class RemoveColumnsFromLichTrinhGiangDays < ActiveRecord::Migration
  def change
  	remove_column :lich_trinh_giang_days, :xac_nhan_sv
  	remove_column :lich_trinh_giang_days, :nhan_xet_buoi_hoc
  	remove_column :lich_trinh_giang_days, :nam_hoc
  	remove_column :lich_trinh_giang_days, :hoc_ky
  	remove_column :lich_trinh_giang_days, :lop_mon_hoc_sinh_vien_id
  end


end
