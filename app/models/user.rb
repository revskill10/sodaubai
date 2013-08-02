class User < ActiveRecord::Base  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  attr_accessible :username, :code, :role
  devise :cas_authenticatable
  belongs_to :imageable, :polymorphic => true
  delegate :lop_mon_hocs, :to => :imageable
  ROLES = %w[admin quansinh daotao giangvien sinhvien]
  

  def cas_extra_attributes=(extra_attributes)
    if extra_attributes["status"] != 0    	    
    		self.code = extra_attributes["masinhvien"]
        svs = SinhVien.where(:ma_sinh_vien => self.code.strip.downcase)
        sv = svs.first unless svs.empty?
        gvs = GiangVien.where(:ma_giang_vien => self.code)
        gv = gvs.first unless gvs.empty?
        if sv
          self.imageable = sv 
          self.role = "sinhvien"
        end
        if gv
          self.imageable = gv 
          self.role = "giangvien"
        end
    end
  end
  
  def is_admin?
    id == 1
  end
end
