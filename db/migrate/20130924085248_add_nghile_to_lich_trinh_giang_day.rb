class AddNghileToLichTrinhGiangDay < ActiveRecord::Migration
  def change
    add_column :lich_trinh_giang_days, :nghile, :boolean
  end
end
