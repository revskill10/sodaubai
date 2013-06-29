class CreateLopGheps < ActiveRecord::Migration
  def change
    create_table :lop_gheps do |t|
      t.string :ma_lop_ghep
      t.string :nam_hoc
      t.integer :hoc_ky
      t.string :ma_lop
      t.string :ma_mon_hoc

      t.timestamps
    end
  end
end
