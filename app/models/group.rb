class Group < ActiveRecord::Base
  attr_accessible :lop_mon_hoc_id, :name

  belongs_to :lop_mon_hoc
  has_many :lop_mon_hoc_sinh_viens

  validates :name, :presence => true
end
