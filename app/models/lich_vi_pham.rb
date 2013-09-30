class LichViPham < ActiveRecord::Base
  attr_accessible :lop_mon_hoc_id, :ngay_vi_pham, :note1, :note2, :phong, :status, :tuan, :user_id, :lenmuon, :vesom, :bogio, :nguoi_duyet_id

  belongs_to :lop_mon_hoc
  belongs_to :user
  belongs_to :nguoi_duyet, :class_name => "User", :foreign_key => :nguoi_duyet_id, :primary_key => :id
end
