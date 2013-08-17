class AddTinChiToSinhVien < ActiveRecord::Migration
  def change
    add_column :sinh_viens, :tin_chi, :boolean
  end
end
