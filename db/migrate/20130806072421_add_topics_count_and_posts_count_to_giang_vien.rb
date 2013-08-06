class AddTopicsCountAndPostsCountToGiangVien < ActiveRecord::Migration
  def change
    add_column :giang_viens, :topics_count, :integer
    add_column :giang_viens, :posts_count, :integer
  end
end
