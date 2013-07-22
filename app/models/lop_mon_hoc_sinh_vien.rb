class LopMonHocSinhVien < ActiveRecord::Base
  attr_accessible :ma_lop, :ma_sinh_vien, :ma_mon_hoc, :ma_lop_hanh_chinh, :ten_mon_hoc, :loai, :ho_dem, :ten
  belongs_to :lop_mon_hoc, :foreign_key => 'ma_lop', :primary_key => 'ma_lop' , :conditions => proc {"lop_mon_hocs.ma_mon_hoc = '#{ma_mon_hoc}'"}
  belongs_to :lop_ghep, :foreign_key => 'ma_lop', :primary_key => 'ma_lop' , :conditions => proc {"lop_gheps.ma_mon_hoc = '#{ma_mon_hoc}'"}
  belongs_to :sinh_vien, :foreign_key => 'ma_sinh_vien', :primary_key => 'ma_sinh_vien'
  belongs_to :group

  validates :ma_lop, :ma_sinh_vien, :ma_mon_hoc, :ten_mon_hoc, :presence => true  
  validate :check_conflict
  
  after_create :set_ngays
  protected
  def check_conflict
  	tkbs = sinh_vien.get_tkbs
  	mtkbs = lop_mon_hoc.get_tkbs
  	res = false
  	tkbs.each do |tkb|
  		break if res = true 
  		mtkbs.each do |tk|
  			if tkb.schedule.conflicts_with?(tk.schedule) then
  				res = true
  				break 
  			end
  		end
  	end
  	errors.add("Lich trung") if res == true
  	# todo
  end
  def set_ngays  	
  	sinh_vien.ngay = sinh_vien.get_days
  	sinh_vien.save rescue "puts error save ngays"
  end
end
