class AddTopicsCountAndPostsCountToLopMonHoc < ActiveRecord::Migration
  def change
    add_column :lop_mon_hocs, :topics_count, :integer
    add_column :lop_mon_hocs, :posts_count, :integer
  end
end
