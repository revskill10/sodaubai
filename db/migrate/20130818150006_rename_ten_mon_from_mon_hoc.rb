class RenameTenMonFromMonHoc < ActiveRecord::Migration
  def change
  	remove_column :mon_hocs, :ten_mon
    add_column :mon_hocs, :ten_mon_hoc, :string
  end
end
