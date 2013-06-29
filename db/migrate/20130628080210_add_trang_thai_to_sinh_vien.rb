class AddTrangThaiToSinhVien < ActiveRecord::Migration
  def change
    add_column :sinh_viens, :trang_thai, :integer
  end
end
