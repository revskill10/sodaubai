class AddNgayThuaToLopMonHoc < ActiveRecord::Migration
  def change
    add_column :lop_mon_hocs, :ngay_thua, :text
  end
end
