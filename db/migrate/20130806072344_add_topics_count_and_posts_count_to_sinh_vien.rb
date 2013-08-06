class AddTopicsCountAndPostsCountToSinhVien < ActiveRecord::Migration
  def change
    add_column :sinh_viens, :topics_count, :integer
    add_column :sinh_viens, :posts_count, :integer
  end
end
