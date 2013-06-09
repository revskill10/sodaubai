class CreateLopMonHocSinhViens < ActiveRecord::Migration
  def change
    create_table :lop_mon_hoc_sinh_viens do |t|
      t.string :ma_sinh_vien
      t.string :ma_lop
      t.string :ma_mon_hoc
      t.string :nam_hoc
      t.integer :hoc_ky

      t.timestamps
    end
  end
end
