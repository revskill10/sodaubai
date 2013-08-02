class AddMaGiangVienToLichTrinhGiangDay < ActiveRecord::Migration
  def change
    add_column :lich_trinh_giang_days, :ma_giang_vien, :string
  end
end
