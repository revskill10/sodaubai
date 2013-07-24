class AddTongVangCoPhepToDiemChuyenCan < ActiveRecord::Migration
  def change
    add_column :diem_chuyen_cans, :tong_vang_co_phep, :integer
  end
end
