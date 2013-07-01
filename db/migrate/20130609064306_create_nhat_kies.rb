class CreateNhatKies < ActiveRecord::Migration
  def change
  	
    create_table :nhat_kies do |t|
      t.string :ma_nguoi_dung
      t.string :ma_lop
      t.text :noi_dung
      t.datetime :thoi_gian

      t.timestamps
    end
  end
end
