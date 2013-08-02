class AddMaGiangVienToDiemDanh < ActiveRecord::Migration
  def change
    add_column :diem_danhs, :ma_giang_vien, :string
  end
end
