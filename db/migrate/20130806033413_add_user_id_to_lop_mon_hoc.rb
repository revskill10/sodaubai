class AddUserIdToLopMonHoc < ActiveRecord::Migration
  def change
    add_column :lop_mon_hocs, :user_id, :integer
  end
end
