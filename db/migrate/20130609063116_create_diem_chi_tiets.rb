class CreateDiemChiTiets < ActiveRecord::Migration
  def change    
    create_table :diem_chi_tiets do |t|
      t.string :ma_sinh_vien
      t.string :ma_lop
      t.string :ma_mon_hoc
      t.string :nam_hoc
      t.integer :hoc_ky
      t.integer :diem
      t.string :loai_diem
      t.integer :lan

      t.timestamps
    end
  end
end
