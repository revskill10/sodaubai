class AddEmailToSinhVien < ActiveRecord::Migration
  def change
    add_column :sinh_viens, :email, :string
  end
end
