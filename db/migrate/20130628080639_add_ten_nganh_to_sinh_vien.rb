class AddTenNganhToSinhVien < ActiveRecord::Migration
  def change
    add_column :sinh_viens, :ten_nganh, :string
  end
end
