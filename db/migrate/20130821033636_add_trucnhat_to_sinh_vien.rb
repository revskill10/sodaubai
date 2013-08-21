class AddTrucnhatToSinhVien < ActiveRecord::Migration
  def change
    add_column :sinh_viens, :trucnhat, :text
  end
end
