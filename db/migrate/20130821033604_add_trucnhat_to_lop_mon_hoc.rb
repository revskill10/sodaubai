class AddTrucnhatToLopMonHoc < ActiveRecord::Migration
  def change
    add_column :lop_mon_hocs, :trucnhat, :text
  end
end
