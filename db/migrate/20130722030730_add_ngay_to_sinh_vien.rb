class AddNgayToSinhVien < ActiveRecord::Migration
  def change
    add_column :sinh_viens, :ngay, :text
  end
end
