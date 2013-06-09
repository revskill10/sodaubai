class CreateKienNghis < ActiveRecord::Migration
  def change
    create_table :kien_nghis do |t|
      t.string :ma_sinh_vien
      t.string :ma_lop
      t.string :ma_mon_hoc
      t.text :noi_dung
      t.string :nam_hoc
      t.integer :hoc_ky
      t.integer :nhom_id
      t.boolean :trang_thai

      t.timestamps
    end
  end
end
