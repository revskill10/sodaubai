class RemoveRedundantColumns < ActiveRecord::Migration
  def change
  	drop_table :can_bo_lops
  	drop_table :dang_ky_day_bus
  	drop_table :day_thays
  	drop_table :diem_chi_tiets
  	drop_table :diem_chuyen_cans
  	drop_table :kien_nghis
  	drop_table :nghi_days
  	drop_table :nhat_kies
  	drop_table :ra_som_vao_muons
  	drop_table :tai_lieu_mon_hocs  	
  	remove_column :diem_danhs, :nam_hoc
  	remove_column :diem_danhs, :hoc_ky
  	remove_column :lop_mon_hocs, :nam_hoc
  	remove_column :lop_mon_hocs, :hoc_ky
  	remove_column :thong_bao_lop_hocs, :nam_hoc
  	remove_column :thong_bao_lop_hocs, :hoc_ky
  	remove_column :tkb_giang_viens, :nam_hoc
  	remove_column :tkb_giang_viens, :hoc_ky
  end
end
