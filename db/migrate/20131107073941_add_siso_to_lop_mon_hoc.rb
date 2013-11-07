class AddSisoToLopMonHoc < ActiveRecord::Migration
  def change
    add_column :lop_mon_hocs, :siso, :integer
  end
end
