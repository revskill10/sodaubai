class AddMaGiangVienThayAndTenGiangVienThayAndStatusToDayThay < ActiveRecord::Migration
  def change
    add_column :day_thays, :ma_giang_vien_thay, :string
    add_column :day_thays, :ten_giang_vien_thay, :string
    add_column :day_thays, :status, :string
  end
end
