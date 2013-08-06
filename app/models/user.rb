class User < ActiveRecord::Base  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  attr_accessible :username, :code
  devise :cas_authenticatable
  belongs_to :imageable, :polymorphic => true
  delegate :lop_mon_hocs, :to => :imageable
  
  has_and_belongs_to_many :groups
  has_many :lop_mon_hocs
  def cas_extra_attributes=(extra_attributes)
    if extra_attributes["status"] != 0    	    
    		self.code = extra_attributes["masinhvien"]
        svs = SinhVien.where(:ma_sinh_vien => self.code.strip.downcase)
        sv = svs.first unless svs.empty?
        gvs = GiangVien.where(:ma_giang_vien => self.code)
        gv = gvs.first unless gvs.empty?
        if sv
          self.imageable = sv           
        end
        if gv
          self.imageable = gv           
        end
    end
  end
  def to_s
    username
  end
  def is_admin?
    id == 1
  end
end
