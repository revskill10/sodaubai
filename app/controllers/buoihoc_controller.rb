require 'date'
class BuoihocController < ApplicationController
  before_filter :load_lop, :only => [:show, :diemdanh]
  def show
  	authorize! :read, @lop_mon_hoc
  	
  end
  
  def diemdanh
    msvs = []
    params.each do |k,v|
      if k.to_s.include?("msv") and v.to_i > 0 then 
        msvs << {:msv => k.to_s, :vang => v.to_i}
      end
    end
    msvs.each do |ms|
      dds = DiemDanh.by_lop_sinhvien_ngay(@malop, ms[:msv], @ngay)
      if dds.empty? then 
        DiemDanh.create(ma_sinh_vien: ms[:msv], ma_lop: @malop, ngay_vang: @ngay, so_tiet_vang: ms[:vang])
      else
        dds.first.update_attributes(so_tiet_vang: ms[:vang])
      end
    end
    respond_to do |format|
      format.js
    end
  end

  protected
  def load_lop
  	@lop_mon_hoc = LopMonHoc.find(params[:lop_mon_hoc_id])  	
    @ngay = DateTime.strptime(params[:id], "%Y-%m-%d")
    @malop = @lop_mon_hoc.ma_lop
    @svs = @lop_mon_hoc.sinh_viens.paginate(:page => params[:page], :per_page => 5)
  end
end
