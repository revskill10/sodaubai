class AddMaLopAndMaMonHocToLichTrinhGiangDay < ActiveRecord::Migration
  def change
    add_column :lich_trinh_giang_days, :ma_lop, :string
    add_column :lich_trinh_giang_days, :ma_mon_hoc, :string
  end
end
