class AddRatingsAndRatingScoreToLichTrinhGiangDay < ActiveRecord::Migration
  def change
    add_column :lich_trinh_giang_days, :ratings, :integer
    add_column :lich_trinh_giang_days, :rating_score, :integer
  end
end
