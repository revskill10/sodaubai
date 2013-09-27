class LichTrucNhat < ActiveRecord::Base
  attr_accessible :lop_mon_hoc_id, :ngay_truc, :phong, :note, :tuan

  has_many :truc_nhats
  belongs_to :lop_mon_hoc
end
