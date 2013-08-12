class User < ActiveRecord::Base  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  attr_accessible :username, :code, :ho_dem, :ten
  devise :cas_authenticatable
  belongs_to :imageable, :polymorphic => true
  
  
  has_and_belongs_to_many :groups
  has_many :lop_mon_hocs
  def cas_extra_attributes=(extra_attributes)
    if extra_attributes["status"] != 0    	    
      if extra_attributes["hovaten"]
        zten = extra_attributes["hovaten"].split(" ").to_a
        self.ten = zten[-1] if zten[-1]
        self.ho_dem = zten[0..-2].join(" ") if zten[0..-2]
      end
	    self.role = 'guest'
      if extra_attributes["masinhvien"]
        self.code = extra_attributes["masinhvien"]
        svs = SinhVien.where(:ma_sinh_vien => self.code)
        sv = svs.first unless svs.empty?
        gvs = GiangVien.where(:ma_giang_vien => self.code)
        gv = gvs.first unless gvs.empty?
        if sv
          sv.user = self     
		      self.role = 'sinhvien'    
          sv.save!
        else
          self.imageable = nil
        end
        if gv
          gv.user = self
		      self.role = 'giangvien'
          gv.save!
        else
          self.imageable = nil
        end
        if lop_mon_hocs.count > 0 
          self.role = 'trogiang'        
        end
      else
        self.code = self.username
        self.role = 'guest'
      end
  		if lop_mon_hocs.count > 0 
  			self.role = 'trogiang'
  		end
    end
  end
  def to_s
    username
  end
  def is_admin?
    username == 'dungth@hpu.edu.vn'
  end
  def fullname
    "#{ho_dem} #{ten}"
  end
  def get_tkbs    
    tkbs = []
    if lop_mon_hocs
      lop_mon_hocs.each do |l|
        tkbs = tkbs + l.tkb_giang_viens if l 
      end
    end
    return tkbs
  end
  def get_days
    ngays = []
    tkbs = get_tkbs
    return nil if tkbs.empty?
    get_tkbs.each do |tkb|
      ngay = JSON.parse(tkb.days)["ngay"]
      ngays = ngays + ngay
    end
    ngays = ngays.sort_by {|h| [h["tuan"], h["time"]]}
    return {:ngay => ngays}
  end
end
