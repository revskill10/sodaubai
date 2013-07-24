class AddNoteAndPhepToDiemDanh < ActiveRecord::Migration
  def change
    add_column :diem_danhs, :note, :text
    add_column :diem_danhs, :phep, :boolean
  end
end
