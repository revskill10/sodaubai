class AddTenKhoaToGiangVien < ActiveRecord::Migration
  def change
    add_column :giang_viens, :ten_khoa, :string
  end
end
