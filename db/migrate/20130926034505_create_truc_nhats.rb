class CreateTrucNhats < ActiveRecord::Migration
  def change
    create_table :truc_nhats do |t|
      t.string :ma_sinh_vien
      t.integer :lich_truc_nhat_id

      t.timestamps
    end
  end
end
