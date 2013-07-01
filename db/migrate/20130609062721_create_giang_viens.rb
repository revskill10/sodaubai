class CreateGiangViens < ActiveRecord::Migration
  def change    
    create_table :giang_viens do |t|
      t.string :ho_ten
      t.string :hoc_vi
      t.string :hoc_ham
      t.string :ma_don_vi
      t.string :ma_loai
      t.string :ma_giang_vien

      t.timestamps
    end
  end
end
