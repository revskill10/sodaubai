class CreateTuans < ActiveRecord::Migration
  def change
    create_table :tuans do |t|
      t.integer :stt
      t.datetime :tu_ngay
      t.datetime :den_ngay

      t.timestamps
    end
  end
end
