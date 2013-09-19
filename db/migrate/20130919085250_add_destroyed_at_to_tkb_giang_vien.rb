class AddDestroyedAtToTkbGiangVien < ActiveRecord::Migration
  def change
    add_column :tkb_giang_viens, :destroyed_at, :datetime
  end
end
