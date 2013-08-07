class AddThucHanhToLopMonHoc < ActiveRecord::Migration
  def change
    add_column :lop_mon_hocs, :thuc_hanh, :boolean
  end
end
