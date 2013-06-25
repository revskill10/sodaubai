class AddTenGiangVienToTkbGiangViens < ActiveRecord::Migration
  def change
    add_column :tkb_giang_viens, :ten_giang_vien, :string
  end
end
