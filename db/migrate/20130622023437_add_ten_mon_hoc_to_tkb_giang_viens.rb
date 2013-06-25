class AddTenMonHocToTkbGiangViens < ActiveRecord::Migration
  def change
    add_column :tkb_giang_viens, :ten_mon_hoc, :string
  end
end
