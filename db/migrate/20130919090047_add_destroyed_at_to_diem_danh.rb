class AddDestroyedAtToDiemDanh < ActiveRecord::Migration
  def change
    add_column :diem_danhs, :destroyed_at, :datetime
  end
end
