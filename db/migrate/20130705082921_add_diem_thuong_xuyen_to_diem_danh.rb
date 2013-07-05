class AddDiemThuongXuyenToDiemDanh < ActiveRecord::Migration
  def change
    add_column :diem_danhs, :diem_thuong_xuyen, :integer
  end
end
