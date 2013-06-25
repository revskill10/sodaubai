class AddDaysToGiangVien < ActiveRecord::Migration
  def change
    add_column :giang_viens, :days, :text
  end
end
