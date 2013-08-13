class CreateSinhViens < ActiveRecord::Migration
  def change    
    create_table :sinh_viens do |t|
      t.string :ma_sinh_vien
      t.string :ho_dem
      t.string :ten
      t.date :ngay_sinh
      t.boolean :gioi_tinh
      t.string :lop_hc
      t.string :ma_khoa_hoc
      t.string :ma_he_dao_tao
      t.string :ma_nganh

      t.timestamps
    end
    add_index :sinh_viens, :ma_sinh_vien
    add_index :sinh_viens, :lop_hc
  end
end
