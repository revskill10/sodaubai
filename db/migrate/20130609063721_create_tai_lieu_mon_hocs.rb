class CreateTaiLieuMonHocs < ActiveRecord::Migration
  def change
    create_table :tai_lieu_mon_hocs do |t|
      t.string :ma_giang_vien
      t.string :ma_lop
      t.string :ma_mon_hoc
      t.text :noi_dung
      t.string :nam_hoc
      t.integer :hoc_ky

      t.timestamps
    end
  end
end
