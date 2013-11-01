class AddCreatorIdToLichTrinhGiangDay < ActiveRecord::Migration
  def change
    add_column :lich_trinh_giang_days, :creator_id, :integer
  end
end
