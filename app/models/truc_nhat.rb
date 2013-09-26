class TrucNhat < ActiveRecord::Base
  attr_accessible :ma_sinh_vien, :status

  belongs_to :lich_truc_nhat
  belongs_to :sinh_vien, :foreign_key => 'ma_sinh_vien', :primary_key => 'ma_sinh_vien'
end
