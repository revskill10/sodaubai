class AddSoVangAndSvAndSisoToLichTrinhGiangDay < ActiveRecord::Migration
  def change
    add_column :lich_trinh_giang_days, :so_vang, :integer
    add_column :lich_trinh_giang_days, :siso, :integer
    add_column :lich_trinh_giang_days, :sv, :text
  end
end
