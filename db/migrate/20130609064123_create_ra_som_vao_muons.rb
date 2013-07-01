class CreateRaSomVaoMuons < ActiveRecord::Migration
  def change    
    create_table :ra_som_vao_muons do |t|
      t.string :ma_giang_vien
      t.string :ma_lop
      t.string :ma_mon_hoc
      t.string :nam_hoc
      t.integer :hoc_ky
      t.datetime :ngay_day
      t.integer :loai
      t.string :phong
      t.integer :tiet

      t.timestamps
    end
  end
end
