class AddDssvToLopMonHoc < ActiveRecord::Migration
  def change
    add_column :lop_mon_hocs, :dssv, :text
  end
end
