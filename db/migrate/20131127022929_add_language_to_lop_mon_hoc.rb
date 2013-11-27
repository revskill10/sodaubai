class AddLanguageToLopMonHoc < ActiveRecord::Migration
  def change
    add_column :lop_mon_hocs, :language, :integer
  end
end
