class AddThang3ToLopMonHoc < ActiveRecord::Migration
  def change
    add_column :lop_mon_hocs, :thang3, :boolean
  end
end
