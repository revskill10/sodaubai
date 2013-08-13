class AddMaLopAndMaMonHocAndMaGiangVienToTopic < ActiveRecord::Migration
  def change
    add_column :topics, :ma_lop, :string
    add_column :topics, :ma_mon_hoc, :string
    add_column :topics, :ma_giang_vien, :string
  end
end
