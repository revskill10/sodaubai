class LichTrucNhat < ActiveRecord::Base
  attr_accessible :lop_mon_hoc_id, :ngay_truc, :phong, :note, :tuan, :user_id

  has_many :truc_nhats
  belongs_to :lop_mon_hoc
  belongs_to :user
end
