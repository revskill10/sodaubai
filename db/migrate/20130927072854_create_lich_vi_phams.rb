class CreateLichViPhams < ActiveRecord::Migration
  def change
    create_table :lich_vi_phams do |t|
      t.datetime :ngay_vi_pham
      t.integer :lop_mon_hoc_id
      t.string :phong
      t.integer :tuan
      t.boolean :lenmuon
      t.boolean :vesom
      t.boolean :bogio
      t.text :note1
      t.text :note2

      t.timestamps
    end
  end
end
