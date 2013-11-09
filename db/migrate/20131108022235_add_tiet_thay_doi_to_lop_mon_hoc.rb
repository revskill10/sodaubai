class AddTietThayDoiToLopMonHoc < ActiveRecord::Migration
  def change
    add_column :lop_mon_hocs, :tiet_thay_doi, :text
  end
end
