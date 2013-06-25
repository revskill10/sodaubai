class AddLoaiToTkbGiangVien < ActiveRecord::Migration
  def change
    add_column :tkb_giang_viens, :loai, :string
  end
end
