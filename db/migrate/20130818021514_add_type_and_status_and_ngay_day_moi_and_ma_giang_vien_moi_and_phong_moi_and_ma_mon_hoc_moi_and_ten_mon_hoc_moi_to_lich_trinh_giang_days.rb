class AddTypeAndStatusAndNgayDayMoiAndMaGiangVienMoiAndPhongMoiAndMaMonHocMoiAndTenMonHocMoiToLichTrinhGiangDays < ActiveRecord::Migration
  def change
    add_column :lich_trinh_giang_days, :type, :integer
    add_column :lich_trinh_giang_days, :status, :integer
    add_column :lich_trinh_giang_days, :ngay_day_moi, :datetime
    add_column :lich_trinh_giang_days, :ma_giang_vien_moi, :string
    add_column :lich_trinh_giang_days, :phong_moi, :string
    add_column :lich_trinh_giang_days, :ma_mon_hoc_moi, :string
    add_column :lich_trinh_giang_days, :ten_mon_hoc_moi, :string
    add_index :lich_trinh_giang_days, :ma_giang_vien_moi
  end
end
