class AddDestroyedAtToLichTrinhGiangDay < ActiveRecord::Migration
  def change
    add_column :lich_trinh_giang_days, :destroyed_at, :datetime
  end
end
