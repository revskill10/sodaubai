class AddTietNghiToLichTrinhGiangDay < ActiveRecord::Migration
  def change
    add_column :lich_trinh_giang_days, :tiet_nghi, :string
  end
end
