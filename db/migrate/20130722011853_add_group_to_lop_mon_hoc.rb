class AddGroupToLopMonHoc < ActiveRecord::Migration
  def change
    add_column :lop_mon_hocs, :group, :integer
  end
end
