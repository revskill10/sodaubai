class AddHoToSinhVien < ActiveRecord::Migration
  def change
    add_column :sinh_viens, :ho, :string
  end
end
