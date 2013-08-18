class RemoveDiemThuongXuyenFromDiemDanh < ActiveRecord::Migration
  def change  	
  	remove_column :diem_danhs, :diem_thuong_xuyen
  end
end
