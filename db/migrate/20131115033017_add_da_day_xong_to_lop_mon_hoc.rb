class AddDaDayXongToLopMonHoc < ActiveRecord::Migration
  def change
    add_column :lop_mon_hocs, :da_day_xong, :boolean
  end
end
