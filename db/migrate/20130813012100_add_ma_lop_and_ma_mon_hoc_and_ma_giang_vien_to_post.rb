class AddMaLopAndMaMonHocAndMaGiangVienToPost < ActiveRecord::Migration
  def change
    add_column :posts, :ma_lop, :string
    add_column :posts, :ma_mon_hoc, :string
    add_column :posts, :ma_giang_vien, :string
  end
end
