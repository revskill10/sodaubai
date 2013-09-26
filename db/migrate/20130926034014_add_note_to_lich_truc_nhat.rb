class AddNoteToLichTrucNhat < ActiveRecord::Migration
  def change
    add_column :lich_truc_nhats, :note, :text
  end
end
