class CreateMonHocs < ActiveRecord::Migration
  def change
    create_table :mon_hocs do |t|
      t.string :ma_mon_hoc
      t.string :ten_mon

      t.timestamps
    end
  end
end
