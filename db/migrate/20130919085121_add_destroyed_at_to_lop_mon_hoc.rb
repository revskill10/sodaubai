class AddDestroyedAtToLopMonHoc < ActiveRecord::Migration
  def change
    add_column :lop_mon_hocs, :destroyed_at, :datetime
  end
end
