class AddUserIdToLichTrinhGiangDay < ActiveRecord::Migration
  def change
    add_column :lich_trinh_giang_days, :user_id, :integer
  end
end
