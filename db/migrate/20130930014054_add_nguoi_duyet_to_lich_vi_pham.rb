class AddNguoiDuyetToLichViPham < ActiveRecord::Migration
  def change
    add_column :lich_vi_phams, :nguoi_duyet_id, :integer
    add_index :lich_vi_phams, :nguoi_duyet_id
  end
end
