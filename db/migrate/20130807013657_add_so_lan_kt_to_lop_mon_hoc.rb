class AddSoLanKtToLopMonHoc < ActiveRecord::Migration
  def change
    add_column :lop_mon_hocs, :so_lan_kt, :integer
  end
end
